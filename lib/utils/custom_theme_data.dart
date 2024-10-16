import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class CustomThemeData {
  static final ThemeData light = ThemeData(
    fontFamily: 'Pretendard',
    appBarTheme: AppBarTheme(
      titleTextStyle: Palette.heading.copyWith(color: Palette.sub),
      centerTitle: true,
      backgroundColor: Palette.background, // Appbar BG
    ),
    scaffoldBackgroundColor: Palette.background, // Scaffold BG
    colorScheme: const ColorScheme.light(
      primary: Palette.primary,
      secondary: Palette.secondary,
    ),
    highlightColor: Colors.transparent, // Modal highlight color
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Palette.primary),
    ),
  );
}
