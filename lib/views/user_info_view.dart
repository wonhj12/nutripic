import 'package:flutter/material.dart';
import 'package:nutripic/components/custom_app_bar.dart';
import 'package:nutripic/view_models/user_info_view_model.dart';
import 'package:provider/provider.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoViewModel userInfoViewModel = context.watch<UserInfoViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: '마이페이지',
        backButton: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(userInfoViewModel.userModel.name ?? 'null')),
          ElevatedButton(
            onPressed: () => userInfoViewModel.logout(),
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );
  }
}
