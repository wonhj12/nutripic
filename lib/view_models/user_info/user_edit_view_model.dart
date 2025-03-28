import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/common/custom_snackbar.dart';
import 'package:nutripic/models/user_model.dart';

class UserEditViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;

  UserEditViewModel({required this.userModel, required this.context}) {
    controller.text = userModel.name ?? '';
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController controller = TextEditingController();
  bool isConfirmBtnEnabled = false;
  bool showErrorText = false;

  bool isLoading = false;

  // 닉네임 수정시 확인 버튼 활성화 여부 변경
  void onChanged(String text) {
    if (controller.text.trim().length < 2) {
      showErrorText = true;
    } else {
      showErrorText = false;
    }

    if (controller.text.trim() == userModel.name) {
      isConfirmBtnEnabled = false;
    } else {
      isConfirmBtnEnabled = true;
    }

    notifyListeners();
  }

  /// 닉네임 변경
  void changeNickname() async {
    if (isConfirmBtnEnabled) {
      isLoading = true;
      notifyListeners();

      await firebaseAuth.currentUser?.updateDisplayName(controller.text.trim());
      userModel.updateName(controller.text.trim());
      isConfirmBtnEnabled = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackbar().show(message: '닉네임을 변경했어요.'));

      isLoading = false;
      notifyListeners();
    }
  }

  /// 로그아웃 후 login 페이지로 이동
  void logout() async {
    await firebaseAuth.signOut();
    userModel.reset();
    if (context.mounted) context.go('/login');
  }
}
