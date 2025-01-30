import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

/// 공지사항 등에서 사용되는 타일 버튼
class ButtonTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const ButtonTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Palette.gray200),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 타일 제목
            Text(title, style: Palette.body2.copyWith(color: Palette.gray900)),

            // 화살표 아이콘
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Palette.gray900,
            )
          ],
        ),
      ),
    );
  }
}
