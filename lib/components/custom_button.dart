import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

/// Custom Button 타입
enum ButtonType {
  normal(Palette.sub),
  cancel(Palette.gray400),
  delete(Palette.delete);

  final Color color;
  const ButtonType(this.color);
}

class CustomButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final ButtonType type;
  final Function()? onPressed;
  const CustomButton({
    super.key,
    required this.label,
    this.width = 55,
    this.height = 30,
    this.type = ButtonType.normal,
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
        ),
        child: Text(label, style: Palette.body),
      ),
    );
  }
}
