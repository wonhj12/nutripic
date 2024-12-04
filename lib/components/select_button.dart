import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

/// Select Button 타입
enum SelectButtonType {
  normal(Palette.sub),
  cancel(Palette.gray400),
  delete(Palette.delete);

  final Color color;
  const SelectButtonType(this.color);
}

class SelectButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final SelectButtonType type;
  final Function()? onPressed;
  const SelectButton({
    super.key,
    required this.label,
    this.width = 55,
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
          backgroundColor: type.color,
          padding: EdgeInsets.zero,
        ),
        child: Text(label, style: Palette.body.copyWith(color: Palette.white)),
      ),
    );
  }
}
