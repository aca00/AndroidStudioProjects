import 'package:flutter/material.dart';

/// List of available accent colors. User can select one of them.
final List<Color> accentColors = [
  Colors.red[400],
  Colors.green[400],
  Colors.blue[800],
  Colors.amberAccent[700]
];

/// Number of items in accentColors list. Used in _mapColorChanged function in
/// theme_bloc.dart.
final int listItems = accentColors.length;

/// Get theme data for themeState. Theme is built on the basis of accent color
/// and brightness
ThemeData getTheme({bool darkBoolCheck, int accentColorCount}) {
  Brightness brightness = _getBrightness(darkBoolCheck);
  Color accentColor = getAccentColor(accentColorCount);
  return ThemeData(
      buttonColor: accentColor,
      brightness: brightness,
      appBarTheme: _appBarTheme(iconColor: accentColor, brightness: brightness),
      floatingActionButtonTheme:
          _floatingActionButtonTheme(color: accentColor));
}

Brightness _getBrightness(bool val) {
  if (val == true) {
    return Brightness.dark;
  } else {
    return Brightness.light;
  }
}

Color getAccentColor(int val) {
  return accentColors[val];
}

AppBarTheme _appBarTheme({Color iconColor, Brightness brightness}) {
  return AppBarTheme(
      textTheme: _getAppBarTitleTheme(brightness: brightness),
      iconTheme: _iconTheme(iconColor),
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      actionsIconTheme: _iconTheme(iconColor));
}

FloatingActionButtonThemeData _floatingActionButtonTheme({Color color}) {
  return FloatingActionButtonThemeData(
    backgroundColor: color,
    elevation: 0,
  );
}

/// Sets Icon color. All Icon color must be the accent color selected by the user
IconThemeData _iconTheme(Color color) {
  return IconThemeData(color: color);
}

/// App Bar title has a default white color which is not modified with
/// brightness change. So a function is created to manually adjust title text
/// color based on the brightness
TextTheme _getAppBarTitleTheme({Brightness brightness}) {
  if (brightness == Brightness.light) {
    return TextTheme(
        headline6: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22));
  } else {
    return TextTheme(
        headline6: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22));
  }
}

Color getStarColor(int i) {
  if (i == 0) {
    return Colors.transparent;
  }
  
}
