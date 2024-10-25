import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String? src;
  final double radius;

  /// 사용자 프로필 이미지 widget
  const ProfileImage({
    super.key,
    required this.src,
    this.radius = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: src != null
          ? ClipOval(
              child: Image.network(
                src!,
                fit: BoxFit.cover,
                width: radius,
                height: radius,
              ),
            )
          : Icon(Icons.person, size: radius),
    );
  }
}
