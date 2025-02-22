import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/common/image_button.dart';
import 'package:nutripic/utils/enums/login_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:provider/provider.dart';
import 'package:nutripic/view_models/login/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.watch<LoginViewModel>();

    return CustomScaffold(
      backgroundColor: Palette.green500,
      isLoading: loginViewModel.isLoading,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: loginViewModel.topPadding()),

          // 로고
          Container(
            margin: const EdgeInsets.all(20),
            child: SvgPicture.asset(
              'assets/icons/nutripic_logo_white.svg',
              width: 90,
              height: 90,
            ),
          ),
          const SizedBox(height: 26),

          // 뉴트리픽
          SvgPicture.asset(
            'assets/icons/nutripic_text_white.svg',
            width: 213,
            height: 51,
          ),
          const SizedBox(height: 130),

          // 카카오 로그인
          ImageButton(
            img: 'login_kakao.svg',
            onTap: () => loginViewModel.login(LoginType.kakao),
          ),
          const SizedBox(height: 10),

          // 구글 로그인
          ImageButton(
            img: 'login_google.svg',
            onTap: () => loginViewModel.login(LoginType.google),
          ),
          const SizedBox(height: 10),

          // 애플 로그인
          ImageButton(
            img: 'login_apple.svg',
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
                  style: Palette.body1.copyWith(color: Palette.gray900),
                ),
              ),

              // Divider
              const SizedBox(
                height: 16,
                child: VerticalDivider(
                  color: Palette.gray900,
                  thickness: 0.5,
                  width: 14,
                ),
              ),

              // 회원가입
              TextButton(
                onPressed: loginViewModel.signup,
                child: Text(
                  '이메일로 회원가입',
                  style: Palette.body1.copyWith(color: Palette.gray900),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
