import 'dart:ui';

import 'package:nutripic/utils/palette.dart';

/// Main Button 타입
enum MainButtonType {
  primary(color: Palette.green500, textColor: Palette.gray00),
  secondary(color: Palette.gray300, textColor: Palette.gray00);

  final Color color;
  final Color textColor;
  const MainButtonType({required this.color, required this.textColor});
}
