import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

/// Select Button 타입
enum BoxButtonType {
  normal(Palette.gray600, Palette.gray100),
  transparent(Palette.gray00, Colors.transparent),
  delete(Palette.gray00, Palette.delete),
  primary(Palette.green600, Palette.gray100);

  final Color color;
  final Color backgroundColor;
  const BoxButtonType(this.color, this.backgroundColor);
}
