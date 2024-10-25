import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class FoodDday extends StatelessWidget {
  final int dDay;
  const FoodDday({super.key, required this.dDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 22,
      decoration: BoxDecoration(
        color: Palette.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Palette.delete, width: 2),
      ),
      child: Center(
        child: Text(
          'D-$dDay',
          style: Palette.body.copyWith(
            color: Palette.delete,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
