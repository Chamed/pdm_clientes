import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xFF1A1A1A),
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
    primary: Color.fromARGB(255, 99, 96, 96),
    secondary: Color(0xFF2E2E2E),
    tertiary: Color(0xFFB0B0B0),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.white,
    ),
  ),
);
