import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class FoodSelect extends StatelessWidget {
  final bool isSelected;
  const FoodSelect({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4,
      left: 4,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: isSelected ? Palette.green400 : Palette.gray00,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Palette.green400 : Palette.gray100,
            width: 1,
          ),
        ),
        child: isSelected
            ? const Icon(Icons.check_rounded, color: Palette.gray00, size: 12)
            : Container(),
      ),
    );
  }
}
