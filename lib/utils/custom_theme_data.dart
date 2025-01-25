import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class CustomThemeData {
  static final ThemeData light = ThemeData(
    fontFamily: 'Pretendard',
    appBarTheme: AppBarTheme(
      titleTextStyle: Palette.subtitle1Medium.copyWith(color: Palette.gray900),
      backgroundColor: Palette.background, // Appbar BG
    ),
    scaffoldBackgroundColor: Palette.background, // Scaffold BG
    colorScheme: const ColorScheme.light(
      primary: Palette.green600,
      primaryContainer: Palette.green50,
      onPrimary: Palette.gray00,
      error: Palette.delete,
    ),
    highlightColor: Colors.transparent, // Modal highlight color
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Palette.green500),
    ),
  );
}
