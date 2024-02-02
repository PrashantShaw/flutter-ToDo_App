// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/theme/theme_provider.dart';

main() async {
  await Hive.initFlutter();
  await Hive.openBox("todoBox");

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // theme: context.read<ThemeProvider>().themeData,
      theme: Provider.of<ThemeProvider>(context).themeData,
      // darkTheme: darkTheme,
      home: HomePage(),
    );
  }
}
