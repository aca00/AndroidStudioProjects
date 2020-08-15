import 'package:flutter/material.dart';

enum AppTheme { light, dark }

Map appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
  ),
  AppTheme.dark: ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0))
};
