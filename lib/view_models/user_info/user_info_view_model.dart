import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/user_model.dart';

class UserInfoViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;
  UserInfoViewModel({required this.userModel, required this.context});

  /// 프로필 수정 페이지로 이동
  void onTapEdit() {
    context.go('/user/edit');
  }
}
