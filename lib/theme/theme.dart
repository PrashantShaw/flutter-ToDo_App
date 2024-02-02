// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.yellow,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.yellow,
    secondary: Colors.yellow.shade700,
    tertiary: Color(0xff0f0f0f),
    background: Colors.yellow.shade200,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.purple.shade900,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.purple.shade900,
    secondary: Colors.orange.shade300,
    tertiary: Colors.white,
    background: Color(0xff121212),
  ),
);
