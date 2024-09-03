import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade900,
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade500,
    secondary: Color.fromARGB(255, 57, 57, 57),
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade200,
    thickness: 1,
  ),
);