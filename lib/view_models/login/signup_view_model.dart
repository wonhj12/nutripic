import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/user_model.dart';
import 'package:nutripic/utils/api.dart';
import 'package:nutripic/utils/validator.dart';

class SignupViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;
  SignupViewModel({required this.userModel, required this.context});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// 회원가입 formKey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 텍스트 컨트롤러
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordCheck = TextEditingController();

  /// 회원가입 오류 텍스트
  String? errorText;

  /// 회원가입 버튼 활성화 여부
  bool isSignupBtnEnabled = false;

  /// 유효성 검사 모드
  AutovalidateMode validateMode = AutovalidateMode.disabled;

  /// 로딩
  bool isLoading = false;

  /// 회원가입 진행하는 함수
  void signup() async {
    isLoading = true;
    errorText = null; // 에러 텍스트 초기화
    // validate 한번 한 후에는 검사 모드 변경
    validateMode = AutovalidateMode.onUserInteraction;
    notifyListeners();

    if (formKey.currentState!.validate()) {
      try {
        // 이메일, 비밀번호를 사용해서 계정 생성, 로그인까지 진행이 됨
        final userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        final user = userCredential.user;

        // 정상적으로 회원가입이 됐으면 입력된 이름 저장
        // UserModel에 사용자 데이터 저장
        // db에 uid 등록
        if (user != null) {
          await API.postUser(user.uid); // db에 uid 등록
          await user.updateDisplayName(name.text.trim()); // 이름 업데이트
          userModel.fromFirebaseUser(_firebaseAuth.currentUser ?? user);
        }

        // 회원가입 완료 후 바로 홈 화면으로 이동
        if (context.mounted) context.go('/onboarding');
      } on FirebaseAuthException catch (e) {
        // https://stackoverflow.com/questions/67617502/what-are-the-error-codes-for-flutter-firebase-auth-exception
        debugPrint('FirebaseAuthException in _emailLogin: ${e.code}');

        switch (e.code) {
          case 'email-already-in-use':
            errorText = '이미 사용 중인 이메일입니다.';
            break;
          case 'invalid-email':
            errorText = '유효하지 않은 이메일입니다.';
            break;
          case 'weak-password':
            errorText = '비밀번호가 너무 약합니다.';
            break;
          case 'network-request-failed':
            errorText = '네트워크 연결에 실패했습니다.';
            break;
          default:
            errorText = e.code;
            break;
        }
      } catch (e) {
        debugPrint('Error in signup: $e');
      }
    }

    isLoading = false;
    notifyListeners();
  }

  /// 이름 유효성 검사
  String? Function(String?) get validateName => nameValidator();

  /// 이메일 유효성 검사
  String? Function(String?) get validateEmail => emailValidator();

  /// 비밀번호 유효성 검사
  String? Function(String?) get validatePassword => passwordValidator();

  /// 비밀번호 유효성 검사
  String? Function(String?) get validatePasswordCheck {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '비밀번호를 입력하세요.';
      }

      if (value != password.text.trim()) {
        return '비밀번호와 일치하지 않습니다.';
      }

      return null;
    };
  }

  /// 이메일, 비밀번호를 입력하면 확인 후 로그인 버튼을 활성화하는 함수
  void Function(String?) onTextFieldChanged() {
    return (String? value) {
      final nameValid = validateName(name.text.trim());
      final emailValid = validateEmail(email.text.trim());
      final passwordValid = validatePassword(password.text.trim());
      final passwordCheckValid =
          validatePasswordCheck(passwordCheck.text.trim());

      if (nameValid == null &&
          emailValid == null &&
          passwordValid == null &&
          passwordCheckValid == null) {
        isSignupBtnEnabled = true;
      } else {
        isSignupBtnEnabled = false;
      }

      notifyListeners();
    };
  }
}
