import 'package:flutter/material.dart';
import 'package:nutripic/components/common/image_button.dart';
import 'package:nutripic/utils/enums/login_type.dart';

class LinkedProviders extends StatelessWidget {
  final LoginType loginType;
  const LinkedProviders({super.key, required this.loginType});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 카카오
        ImageButton(
          width: 40,
          height: 40,
          radius: 20,
          img: loginType == LoginType.kakao
              ? 'kakao_enabled.svg'
              : 'kakao_disabled.svg',
          onTap: () {},
        ),
        const SizedBox(width: 12),

        // 구글
        ImageButton(
          width: 40,
          height: 40,
          radius: 20,
          img: loginType == LoginType.google
              ? 'google_enabled.svg'
              : 'google_disabled.svg',
          onTap: () {},
        ),
        const SizedBox(width: 12),

        // 애플
        ImageButton(
          width: 40,
          height: 40,
          radius: 20,
          img: loginType == LoginType.apple
              ? 'apple_enabled.svg'
              : 'apple_disabled.svg',
          onTap: () {},
        ),

        // 이메일
      ],
    );
  }
}
