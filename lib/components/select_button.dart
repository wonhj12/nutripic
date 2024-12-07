import 'package:flutter/material.dart';
import 'package:nutripic/utils/enums/select_button_type.dart';
import 'package:nutripic/utils/palette.dart';

class SelectButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final SelectButtonType type;
  final Function()? onPressed;
  const SelectButton({
    super.key,
    required this.label,
    this.width = 56,
    this.height = 30,
    this.type = SelectButtonType.normal,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: type.backgroundColor,
          padding: EdgeInsets.zero,
        ),
        child: Text(label, style: Palette.subtitle.copyWith(color: type.color)),
      ),
    );
  }
}
