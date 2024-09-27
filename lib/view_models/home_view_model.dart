import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeViewModel with ChangeNotifier {
  BuildContext context;
  HomeViewModel({required this.context});

  void logout() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) context.go('/login');
  }
}
