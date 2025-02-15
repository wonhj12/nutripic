import 'package:flutter/material.dart';
import 'package:nutripic/utils/enums/main_button_type.dart';
import 'package:nutripic/utils/palette.dart';

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
    this.height = 50,
    this.type = MainButtonType.enabled,
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
          style: Palette.title1Medium.copyWith(color: type.textColor),
        ),
      ),
    );
  }
}
