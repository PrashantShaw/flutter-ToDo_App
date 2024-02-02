// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/theme/theme_provider.dart';

AppBar homeAppBar(ColorScheme colorScheme, BuildContext context) {
  return AppBar(
    // backgroundColor: colorScheme.tertiary,
    bottomOpacity: 0.1,
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.grain),
    ),
    title: Center(
      child: Text(
        "TO DO",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            var themeProvider = context.read<ThemeProvider>();
            themeProvider.toggleThemeData();
          },
          icon: Icon(Icons.light_mode))
    ],
  );
}
