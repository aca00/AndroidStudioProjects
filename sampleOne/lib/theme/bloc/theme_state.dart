part of 'theme_bloc.dart';

/// it may be possible that all these stuffs can be achieved through single class
/// but for the sake of simplicity and better understanding I decide to keep it
/// as it is now.
class ThemeState {
  bool check;
  ThemeData myTheme;
  ThemeState(this.check) {
    if (check == false) {
      myTheme = appThemeData[AppThemes.light];
    } else {
      myTheme = appThemeData[AppThemes.dark];
    }
    debugPrint('myTheme: ${this.myTheme}');
  }
}

class ThemeInitial extends ThemeState {
  ThemeInitial(bool check) : super(check);
}

class ThemeChangedState extends ThemeState {
  ThemeChangedState(bool check) : super(check);
}
