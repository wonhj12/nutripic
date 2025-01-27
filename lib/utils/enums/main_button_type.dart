import 'dart:ui';

import 'package:nutripic/utils/palette.dart';

/// Main Button 타입
enum MainButtonType {
  primary(color: Palette.green50, textColor: Palette.gray00),
  secondary(color: Palette.gray100, textColor: Palette.gray400);

  final Color color;
  final Color textColor;
  const MainButtonType({required this.color, required this.textColor});
}
