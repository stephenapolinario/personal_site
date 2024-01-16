import 'package:calculator/theme/dark_theme.dart';
import 'package:calculator/theme/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = (_themeData == lightTheme) ? darkTheme : lightTheme;
    notifyListeners();
  }
}
