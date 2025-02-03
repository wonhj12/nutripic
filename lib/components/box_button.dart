import 'package:flutter/material.dart';
import 'package:nutripic/utils/enums/box_button_type.dart';
import 'package:nutripic/utils/palette.dart';

class BoxButton extends StatelessWidget {
  /// 표시 레이블
  final String label;

  /// 버튼 색 종류
  final BoxButtonType type;

  /// small, medium 크기 여부
  /// <br /> `true` = small
  final bool s;

  /// 버튼 클릭
  final Function()? onPressed;

  const BoxButton({
    super.key,
    required this.label,
    this.type = BoxButtonType.normal,
    this.s = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: s ? 56 : 64,
      height: s ? 32 : 36,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: type.backgroundColor,
          padding: EdgeInsets.zero,
        ),
        child: Text(label,
            style: Palette.subtitle1Medium.copyWith(color: type.color)),
      ),
    );
  }
}
