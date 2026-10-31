import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nextask/theme/theme.dart';
class ThemeProvider extends ChangeNotifier{
  bool isdark = false;

ThemeData _themeData = ThemeD().lightMode;

ThemeData getTheme(){
  return _themeData;
}

void trigger (){
isdark = !isdark;
_themeData = isdark ? ThemeD().darkMode : ThemeD().lightMode;
notifyListeners();
}

}