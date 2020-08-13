part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  final bool check;
  ThemeData myTheme;
  ThemeState(this.check) {
    if (check == true) {
      myTheme = appThemeData['dark'];
    } else {
      myTheme = appThemeData['light'];
    }
  }
}

class ThemeInitial extends ThemeState {
  ThemeInitial(bool check) : super(check);
}
