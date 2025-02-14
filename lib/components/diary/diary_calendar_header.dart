import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class DiaryCalendarHeader extends StatelessWidget {
  final Function()? onTapLeft;
  final int month;
  final Function()? onTapRight;
  final Function()? onTapAdd;

  const DiaryCalendarHeader({
    super.key,
    required this.onTapLeft,
    required this.month,
    required this.onTapRight,
    required this.onTapAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // 이전 달 이동 버튼
            IconButton(
              onPressed: onTapLeft,
              icon: const Icon(
                Icons.chevron_left,
                size: 24,
                color: Palette.gray700,
              ),
            ),

            // 현재 달
            Text(
              '$month월',
              style: Palette.subtitle1SemiBold.copyWith(color: Palette.gray900),
            ),

            // 다음 달 이동 버튼
            IconButton(
              onPressed: onTapRight,
              icon: const Icon(
                Icons.chevron_right,
                size: 24,
                color: Palette.gray700,
              ),
            ),
          ],
        ),

        // 다이어리 생성 화면 이동 버튼
        IconButton(
          onPressed: onTapAdd,
          icon: const Icon(
            Icons.add,
            size: 24,
            color: Palette.gray900,
          ),
        ),
      ],
    );
  }
}
