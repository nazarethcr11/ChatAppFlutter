import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.grey,
    thickness: 1,
  ),
);