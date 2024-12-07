import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class FoodDday extends StatelessWidget {
  final int dDay;
  const FoodDday({super.key, required this.dDay});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: 62,
        height: 16,
        decoration: const BoxDecoration(
          color: Palette.delete,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            'D-$dDay',
            style: Palette.caption.copyWith(color: Palette.white),
          ),
        ),
      ),
    );
  }
}
