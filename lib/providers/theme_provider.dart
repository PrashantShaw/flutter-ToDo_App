import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/utils/constants.dart';

class AppThemeData extends ChangeNotifier {
  static final Box box = Hive.box(Constants.todoHiveName);

  ThemeData _themeData =
      box.get("PREF_THEME") == 'dark' ? darkTheme : lightTheme;

  ThemeData get themeData => _themeData;

  void toggleThemeData() {
    ThemeData newThemeData = _themeData == lightTheme ? darkTheme : lightTheme;
    _themeData = newThemeData;
    notifyListeners();
    String newPrefTheme = box.get("PREF_THEME") == 'dark' ? 'light' : 'dark';
    box.put("PREF_THEME", newPrefTheme);
  }
}

final themeDataProvider =
    ChangeNotifierProvider<AppThemeData>((ref) => AppThemeData());
