import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class DiaryCalendarHeader extends StatelessWidget {
  final Function()? onTapLeft;
  final int month;
  final Function()? onTapRight;
  const DiaryCalendarHeader({
    super.key,
    required this.onTapLeft,
    required this.month,
    required this.onTapRight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTapLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: const Icon(
              Icons.chevron_left,
              size: 24,
              color: Palette.black,
            ),
          ),
        ),
        Text(
          '$month월',
          style: Palette.subtitle,
        ),
        GestureDetector(
          onTap: onTapRight,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: const Icon(
              Icons.chevron_right,
              size: 24,
              color: Palette.black,
            ),
          ),
        ),
      ],
    );
  }
}
