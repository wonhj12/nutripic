import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class ImageConfirmSelect extends StatelessWidget {
  final bool isSelected;
  const ImageConfirmSelect({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 6,
      right: 6,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: isSelected ? Palette.green400 : Palette.gray100,
          shape: BoxShape.circle,
          border: Border.all(
            color: Palette.gray00,
            width: 2,
          ),
        ),
        child: isSelected
            ? const Icon(Icons.check_rounded, color: Palette.gray00, size: 14)
            : Container(),
      ),
    );
  }
}
