import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutripic/view_models/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이메일 TextFormField
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => loginViewModel.email = value,
            ),
            const SizedBox(height: 8),

            // 비밀번호 TextFormField
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value) => loginViewModel.password = value,
            ),
            const SizedBox(height: 8),

            // 이메일 로그인
            ElevatedButton(
              onPressed: () => loginViewModel.login(0),
              child: const Text('로그인'),
            ),

            // 카카오 로그인
            ElevatedButton(
              onPressed: () => loginViewModel.login(1),
              child: const Text('카카오'),
            ),

            // 구글 로그인
            ElevatedButton(
              onPressed: () => loginViewModel.login(2),
              child: const Text('구글'),
            ),

            // 애플 로그인
            ElevatedButton(
              onPressed: () => loginViewModel.login(3),
              child: const Text('애플'),
            ),
          ],
        ),
      ),
    );
  }
}
