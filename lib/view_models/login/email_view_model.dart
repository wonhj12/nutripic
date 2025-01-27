import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/user_model.dart';

class EmailViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;
  EmailViewModel({required this.userModel, required this.context});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // 로그인 formKey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 이메일, 비밀번호
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  /// 로그인 오류 텍스트
  String? errorText;

  /// 로그인 버튼 활성화 여부
  bool isLoginBtnEnabled = false;

  /// 로딩 여부
  bool isLoading = false;

  // 상단부터 로고까지 space 길이
  double topPadding() {
    return 128 - MediaQuery.of(context).padding.top;
  }

  /// 이메일 로그인
  void emailLogin() async {
    isLoading = true;
    errorText = null; // 에러 텍스트 초기화
    notifyListeners();

    if (formKey.currentState!.validate()) {
      try {
        final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        final user = userCredential.user;

        if (user != null) {
          // User Model에 사용자 정보 저장
          userModel.fromFirebaseUser(user);

          if (context.mounted) context.go('/refrigerator');
        }
      } on FirebaseAuthException catch (e) {
        // https://stackoverflow.com/questions/67617502/what-are-the-error-codes-for-flutter-firebase-auth-exception
        // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
        debugPrint('FirebaseAuthException in _emailLogin: ${e.code}');

        // 오류 확인
        switch (e.code) {
          case 'user-not-found' || 'wrong-password' || 'invalid-credential':
            errorText = '이메일 혹은 비밀번호가 일치하지 않습니다.';
            break;
          case 'user-disabled':
            errorText = '비활성화된 계정입니다.';
            break;
          case 'network-request-failed':
            errorText = '네트워크 연결에 실패했습니다.';
            break;
          default:
            errorText = e.code;
            break;
        }
      } catch (e) {
        debugPrint('Error in _emailLogin: $e');
      }
    }

    isLoading = false;
    notifyListeners();
  }

  /// 이메일 유효성 검사
  String? Function(String?) validateEmail() {
    return (String? value) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

      if (value == null || value.trim().isEmpty) {
        return '이메일을 입력하세요.';
      }

      if (!emailRegex.hasMatch(value.trim())) {
        return '유효하지 않은 이메일 주소입니다.';
      }

      return null;
    };
  }

  /// 비밀번호 유효성 검사
  String? Function(String?) validatePassword() {
    return (String? value) {
      final passwordRegex = RegExp(
          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

      if (value == null || value.trim().isEmpty) {
        return '비밀번호를 입력하세요.';
      }

      if (!passwordRegex.hasMatch(value.trim())) {
        return '유효하지 않은 비밀번호입니다.';
      }

      return null;
    };
  }

  /// 이메일, 비밀번호를 입력하면 확인 후 로그인 버튼을 활성화하는 함수
  void Function(String?) onTextFieldChanged() {
    return (String? value) {
      final emailValid = validateEmail()(email.text.trim());
      final passwordValid = validatePassword()(password.text.trim());

      if (emailValid == null && passwordValid == null) {
        isLoginBtnEnabled = true;
      } else {
        isLoginBtnEnabled = false;
      }

      notifyListeners();
    };
  }
}
