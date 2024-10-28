import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/user_model.dart';

class EmailViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;
  EmailViewModel({required this.userModel, required this.context});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // 이메일, 비밀번호
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // 상단부터 로고까지 space 길이
  double topPadding() {
    return 128 - MediaQuery.of(context).padding.top;
  }

  /// 이메일 로그인
  void emailLogin() async {
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
    } catch (e) {
      debugPrint('Error in _emailLogin: $e');
    }
  }
}
