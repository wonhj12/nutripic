import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

/// Main Button 타입
enum MainButtonType {
  primary(color: Palette.sub, textColor: Palette.white),
  secondary(color: Palette.gray100, textColor: Palette.gray400);

  final Color color;
  final Color textColor;
  const MainButtonType({required this.color, required this.textColor});
}

class MainButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final MainButtonType type;
  final Function()? onPressed;
  const MainButton({
    super.key,
    required this.label,
    this.width = double.infinity,
    this.height = 60,
    this.type = MainButtonType.primary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: type.color,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: Palette.title.copyWith(color: type.textColor),
        ),
      ),
    );
  }
}
