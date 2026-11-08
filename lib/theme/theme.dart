import 'package:flutter/material.dart';

class ThemeD {
  ThemeData lightMode = ThemeData(
    brightness: .light,
    colorScheme: ColorScheme.light(
      primary: Colors.amber,
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
        inverseSurface: Colors.amber,
        inversePrimary: Colors.amber,
      surface: Colors.grey.shade900,
      onPrimary: Colors.grey.shade800
    ),
  );
}
