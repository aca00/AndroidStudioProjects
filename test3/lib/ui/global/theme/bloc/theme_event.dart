import 'package:flutter/cupertino.dart';

import 'bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test3/ui/global/theme/app_theme.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  //const ThemeEvent();
  ThemeEvent([List props = const <dynamic>[]]) : super();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;
  @override
  List<Object> get props => [];
  ThemeChanged({
    @required this.theme,
  }) : super([theme]);
}
