import 'package:flutter/material.dart';

var outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    side: const BorderSide(width: 1.5, color: Colors.green),
  ),
);

final ThemeData themeData = ThemeData(
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  outlinedButtonTheme: outlinedButtonTheme,
  useMaterial3: true,
);
