import 'package:flutter/material.dart';

class ThemeD {
  ThemeData lightMode = ThemeData(
    brightness: .light,
    colorScheme: ColorScheme.light(
      primary: Colors.amber.shade300,
      inverseSurface: Colors.black,
      surface: Colors.white,
      inversePrimary: Colors.white,
      onPrimary: Colors.white70
    ),
  );
  ThemeData darkMode = ThemeData(
    brightness: .dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.grey.shade800,
        inverseSurface: Colors.amber.shade300,
        inversePrimary: Colors.amber.shade300,
      surface: Colors.grey.shade900,
      onPrimary: Colors.grey.shade800
    ),
  );
}
