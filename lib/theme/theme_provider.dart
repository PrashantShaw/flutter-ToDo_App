import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  static final Box box = Hive.box("todoBox");

  ThemeData _themeData =
      box.get("PREF_THEME") == 'dark' ? darkTheme : lightTheme;

  ThemeData get themeData => _themeData;

  // set themeData(ThemeData themeData) {
  //   _themeData = themeData;
  //   notifyListeners();
  // }

  void toggleThemeData() {
    ThemeData newThemeData = _themeData == lightTheme ? darkTheme : lightTheme;
    _themeData = newThemeData;
    notifyListeners();
    String newPrefTheme = box.get("PREF_THEME") == 'dark' ? 'light' : 'dark';
    box.put("PREF_THEME", newPrefTheme);
  }
}
