import 'package:flutter/material.dart';
import 'package:nutripic/components/custom_app_bar.dart';
import 'package:nutripic/view_models/signup_view_model.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    SignupViewModel signupViewModel = context.watch<SignupViewModel>();
    return Scaffold(
      appBar: const CustomAppBar(title: '회원가입'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 이름
          const Text('이름'),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => signupViewModel.name = value,
          ),
          const SizedBox(height: 8),

          // 이메일
          const Text('이메일'),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => signupViewModel.email = value,
          ),
          const SizedBox(height: 8),

          // 비밀번호
          const Text('비밀번호'),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => signupViewModel.password = value,
          ),
          const SizedBox(height: 8),

          // 비밀번호 확인
          const Text('비밀번호 확인'),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => signupViewModel.passwordCheck = value,
          ),
          const SizedBox(height: 8),

          // 회원가입
          ElevatedButton(
            onPressed: () => signupViewModel.signup(),
            child: const Text('회원가입'),
          ),
        ],
      ),
    );
  }
}
