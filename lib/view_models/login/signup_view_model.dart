import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/user_model.dart';

class SignupViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;
  SignupViewModel({required this.userModel, required this.context});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String name = '';
  String email = '';
  String password = '';
  String passwordCheck = '';

  /// 회원가입 진행하는 함수
  void signup() async {
    try {
      // 이메일, 비밀번호를 사용해서 계정 생성, 로그인까지 진행이 됨
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password.trim(),
      );
      final user = userCredential.user;

      // 정상적으로 회원가입이 됐으면 입력된 이름 저장
      // UserModel에 사용자 데이터 저장
      if (user != null) {
        user.updateDisplayName(name);
        userModel.fromFirebaseUser(user);
        // updateDisplayName이 바로 반영되지 않기 때문에 수동으로 UserModel에 업데이트
        userModel.name = name;
      }

      // 회원가입 완료 후 바로 홈 화면으로 이동
      if (context.mounted) context.go('/refrigerator');
    } on FirebaseAuthException catch (e) {
      // https://stackoverflow.com/questions/67617502/what-are-the-error-codes-for-flutter-firebase-auth-exception
      debugPrint('FirebaseAuthException in _emailLogin: ${e.code}');
    } catch (e) {
      debugPrint('Error in signup: $e');
    }
  }
}
