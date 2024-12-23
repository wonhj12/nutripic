import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/login/image_button.dart';
import 'package:nutripic/utils/enums/login_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:provider/provider.dart';
import 'package:nutripic/view_models/login/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.watch<LoginViewModel>();

    return CustomScaffold(
      isLoading: loginViewModel.isLoading,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: loginViewModel.topPadding()),

          // 로고
          Container(
            margin: const EdgeInsets.all(20),
            child: SvgPicture.asset(
              'assets/icons/logo_no_bg.svg',
              width: 64,
              height: 64,
            ),
          ),
          const SizedBox(height: 15),

          // 뉴트리픽
          SvgPicture.asset(
            'assets/icons/nutripic.svg',
            width: 194,
            height: 52,
          ),
          const SizedBox(height: 154),

          // 카카오 로그인
          ImageButton(
            img: 'assets/icons/login_kakao.svg',
            onTap: () => loginViewModel.login(LoginType.kakao),
          ),
          const SizedBox(height: 10),

          // 구글 로그인
          ImageButton(
            img: 'assets/icons/login_google.svg',
            onTap: () => loginViewModel.login(LoginType.google),
          ),
          const SizedBox(height: 10),

          // 애플 로그인
          ImageButton(
            img: 'assets/icons/login_apple.svg',
            onTap: () => loginViewModel.login(LoginType.apple),
          ),
          const SizedBox(height: 25),

          // 이메일 로그인/회원가입
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 이메일 로그인
              TextButton(
                onPressed: loginViewModel.emailLogin,
                child: Text(
                  '이메일로 로그인',
                  style: Palette.body.copyWith(color: Palette.black),
                ),
              ),

              // Divider
              const SizedBox(
                height: 16,
                child: VerticalDivider(
                  color: Palette.black,
                  thickness: 0.5,
                  width: 14,
                ),
              ),

              // 회원가입
              TextButton(
                onPressed: loginViewModel.signup,
                child: Text(
                  '이메일로 회원가입',
                  style: Palette.body.copyWith(color: Palette.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
