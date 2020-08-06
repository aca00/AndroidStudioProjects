import 'package:flutter/material.dart';

enum AppTheme {
  LightMode,
  DarkMode,
}

final appThemeData = {
  AppTheme.LightMode: ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          brightness: Brightness.light, color: Colors.white, elevation: 0.0)),
  AppTheme.DarkMode: ThemeData(
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
          brightness: Brightness.dark, color: Colors.black, elevation: 0.0)),
};
