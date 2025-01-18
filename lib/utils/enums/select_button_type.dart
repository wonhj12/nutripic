import 'dart:ui';

import 'package:nutripic/utils/palette.dart';

/// Select Button 타입
enum SelectButtonType {
  normal(Palette.gray600, Palette.gray100),
  delete(Palette.gray00, Palette.delete);

  final Color color;
  final Color backgroundColor;
  const SelectButtonType(this.color, this.backgroundColor);
}
