part of 'theme_bloc.dart';

class ThemeState {
  ThemeData themeData;
  bool val;
  ThemeState({bool darkBoolCheck, int accentColorCount}) {
    this.val = darkBoolCheck;
    this.themeData = getTheme(
        darkBoolCheck: darkBoolCheck, accentColorCount: accentColorCount);
  }
}
