import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = ThemeData.light();
  ThemeData get theme => _theme;
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _theme = _isDarkTheme ? ThemeData.dark(
    
    ) : ThemeData.light();
    print("Theme toggled. Is Dark Theme: $_isDarkTheme"); // Debug print

    notifyListeners();
  }
}
