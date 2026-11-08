import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nextask/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isdark = false;

  ThemeData _themeData = ThemeD().lightMode;

  ThemeData getTheme() {
    return _themeData;
  }
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    isdark = prefs.getBool('isDark') ?? false;

    _themeData = isdark ? ThemeD().darkMode : ThemeD().lightMode;

    notifyListeners();
  }

  Future<void> saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isdark);
  }


  void trigger() {
    isdark = !isdark;
    _themeData = isdark ? ThemeD().darkMode : ThemeD().lightMode;
    notifyListeners();
  }
}
