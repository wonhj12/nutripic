import 'dart:ui';

import 'package:nutripic/utils/palette.dart';

/// Select Button 타입
enum SelectButtonType {
  normal(Palette.sub, Palette.subContainer),
  cancel(Palette.gray700, Palette.gray100),
  delete(Palette.delete, Palette.deleteContainer);

  final Color color;
  final Color backgroundColor;
  const SelectButtonType(this.color, this.backgroundColor);
}
