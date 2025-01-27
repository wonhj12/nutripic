import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class CustomThemeData {
  static final ThemeData light = ThemeData(
    fontFamily: 'Pretendard',
    appBarTheme: AppBarTheme(
      titleTextStyle: Palette.heading.copyWith(color: Palette.green500),
      centerTitle: true,
      backgroundColor: Palette.gray00, // Appbar BG
    ),
    scaffoldBackgroundColor: Palette.gray00, // Scaffold BG
    colorScheme: const ColorScheme.light(
      primary: Palette.green700,
      primaryContainer: Palette.green500,
      secondary: Palette.green600,
      error: Palette.delete,
    ),
    highlightColor: Colors.transparent, // Modal highlight color
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Palette.green500),
    ),
  );
}
