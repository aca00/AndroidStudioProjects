part of 'theme_bloc.dart';

class ThemeState {
  bool check;
  ThemeData appTheme;
  ThemeState(this.check) {
    debugPrint('check: $check');
    assert(check != null);
    if (check == true) {
      appTheme = appThemeData[AppTheme.dark];
    } else {
      appTheme = appThemeData[AppTheme.light];
    }
  }
}
