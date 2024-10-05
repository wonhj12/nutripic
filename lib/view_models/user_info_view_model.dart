import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/user_model.dart';

class UserInfoViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;
  UserInfoViewModel({required this.userModel, required this.context});

  /// 로그아웃 후 login 페이지로 이동
  void logout() async {
    await FirebaseAuth.instance.signOut();
    userModel.reset();
    if (context.mounted) context.go('/login');
  }
}
