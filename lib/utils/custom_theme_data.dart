import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class CustomThemeData {
  static final ThemeData light = ThemeData(
    fontFamily: 'Pretendard',

    // AppBar 테마
    appBarTheme: AppBarTheme(
      titleTextStyle: Palette.body1.copyWith(color: Palette.gray800),
      centerTitle: true,
      scrolledUnderElevation: 0,
      foregroundColor: Palette.gray800,
      backgroundColor: Palette.gray00, // Appbar BG
    ),

    // Scaffold 테마
    scaffoldBackgroundColor: Palette.gray00, // Scaffold BG

    // 앱 전체적인 테마
    colorScheme: const ColorScheme.light(
      error: Palette.delete,
    ),
    highlightColor: Colors.transparent, // Modal highlight color
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Palette.gray400),
    ),
  );
}
