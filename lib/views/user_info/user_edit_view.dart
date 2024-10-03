import 'package:flutter/material.dart';
import 'package:nutripic/components/custom_app_bar.dart';
import 'package:nutripic/components/custom_scaffold.dart';
import 'package:nutripic/view_models/user_info/user_edit_view_model.dart';
import 'package:provider/provider.dart';

class UserEditView extends StatefulWidget {
  const UserEditView({super.key});

  @override
  State<UserEditView> createState() => _UserEditViewState();
}

class _UserEditViewState extends State<UserEditView> {
  @override
  Widget build(BuildContext context) {
    UserEditViewModel userEditViewModel = context.watch<UserEditViewModel>();
    return CustomScaffold(
      appBar: const CustomAppBar(title: '프로필 수정'),
      body: ElevatedButton(
        onPressed: () => userEditViewModel.logout(),
        child: const Text('로그아웃'),
      ),
    );
  }
}
