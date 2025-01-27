import 'dart:ui';

import 'package:nutripic/utils/palette.dart';

/// Main Button 타입
enum MainButtonType {
  enabled(color: Palette.green500, textColor: Palette.gray00),
  disabled(color: Palette.gray200, textColor: Palette.gray400);

  final Color color;
  final Color textColor;
  const MainButtonType({required this.color, required this.textColor});
}
