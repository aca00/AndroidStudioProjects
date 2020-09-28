part of 'theme_bloc.dart';

class ThemeState {
  int accentcolor;
  ThemeData themeData;
  bool val;
  ThemeState({bool darkBoolCheck, int accentColorCount}) {
    this.accentcolor = accentColorCount;
    this.val = darkBoolCheck;
    this.themeData = getTheme(
        darkBoolCheck: darkBoolCheck, accentColorCount: accentColorCount);
  }
}
