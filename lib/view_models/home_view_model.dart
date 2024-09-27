import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/user_model.dart';

class HomeViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;
  HomeViewModel({required this.userModel, required this.context});

  void logout() async {
    await FirebaseAuth.instance.signOut();
    userModel.reset();
    if (context.mounted) context.go('/login');
  }
}
