import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.blueGrey.shade300,
    surface: Colors.blueGrey.shade100,
    primary: Colors.blueGrey.shade700,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.blueGrey.shade900,
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.grey,
    thickness: 1,
  ),
);