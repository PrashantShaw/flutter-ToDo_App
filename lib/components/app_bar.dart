// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/theme_provider.dart';

AppBar homeAppBar() {
  return AppBar(
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
      Consumer(
        builder: (context, ref, child) {
          return IconButton(
            onPressed: () {
              var appTheme = ref.watch(themeDataProvider);
              appTheme.toggleThemeData();
            },
            icon: Icon(Icons.light_mode),
          );
        },
      )
    ],
  );
}
