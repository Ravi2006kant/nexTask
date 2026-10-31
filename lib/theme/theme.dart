import 'package:flutter/material.dart';

class ThemeD {
  ThemeData lightMode = ThemeData(
    brightness: .light,
    colorScheme: ColorScheme.light(
      primary: Colors.amber,
      surface: Colors.white,
      onPrimary: Colors.white70
    ),
  );
  ThemeData darkMode = ThemeData(
    brightness: .dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.grey.shade800,
      surface: Colors.grey.shade900,
      onPrimary: Colors.grey.shade800
    ),
  );
}
