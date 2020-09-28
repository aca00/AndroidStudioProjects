import 'package:flutter/cupertino.dart';
import '../app_theme.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  //const ThemeEvent();
  ThemeEvent([List props = const <dynamic>[]]) : super();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;
  @override
  List<Object> get props => [theme];
  ThemeChanged({
    @required this.theme,
  }) : super([theme]);
}
