import 'package:flutter/material.dart';

class ThemeProvider {
  static final lightTheme = ThemeData.from(
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 57, 76, 181),
      secondary: Color.fromARGB(255, 247, 228, 49),
      surface: Color(0xFFBDBDBD),
      background: Color(0xFFFFFFFF),
      error: Color.fromARGB(255, 225, 50, 38),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF757575),
      onSurface: Color(0xFF212121),
      onBackground: Color(0xFF000000),
      onError: Color(0xFFFFFFFF),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );
  static final darkTheme = ThemeData.from(
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 57, 76, 181),
      secondary: Color.fromARGB(255, 247, 228, 49),
      surface: Color(0xFF121212),
      background: Color(0xFF121212),
      error: Color.fromARGB(255, 225, 50, 38),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFFFFFFFF),
      onBackground: Color(0xFFFFFFFF),
      onError: Color(0xFFFFFFFF),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
