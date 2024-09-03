import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade900,
    surface: Colors.grey.shade900,
    primary: Colors.blueGrey.shade300,
    secondary: Color.fromARGB(255, 57, 57, 57),
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.blueGrey.shade100,
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade200,
    thickness: 1,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey.shade700,
    contentTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
);