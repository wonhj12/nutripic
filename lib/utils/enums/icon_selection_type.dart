import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:nutripic/utils/palette.dart';

/// Main Button 타입
enum IconSelectionType {
  small(
    size: 18,
    strokeWidth: 1,
    activeStrokeColor: Palette.green400,
    inactiveStrokeColor: Palette.gray200,
    activeFillColor: Palette.green400,
    inactiveFillColor: Palette.gray00,
  ),
  large(
    size: 22,
    strokeWidth: 2,
    activeStrokeColor: Palette.gray00,
    inactiveStrokeColor: Palette.gray00,
    activeFillColor: Palette.green400,
    inactiveFillColor: Palette.gray100,
  );

  final double size;
  final double strokeWidth;
  final Color activeStrokeColor;
  final Color inactiveStrokeColor;
  final Color activeFillColor;
  final Color inactiveFillColor;
  const IconSelectionType({
    required this.size,
    required this.strokeWidth,
    required this.activeStrokeColor,
    required this.inactiveStrokeColor,
    required this.activeFillColor,
    required this.inactiveFillColor,
  });
}
