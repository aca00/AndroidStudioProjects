import 'dart:async';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sampleOne/config/config.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  Config config = Config();
  ThemeBloc(bool check) : super(ThemeInitial(check));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChangedEvent) {
      yield* _mapThemeChangedEvent();
    }
  }

  Stream<ThemeState> _mapThemeChangedEvent() async* {
    bool currentVal = await config.loadBool();
    bool newVal = !currentVal;
    await config.saveBool(newVal);
    debugPrint('Newval: $newVal');
    yield ThemeChangedState(newVal);
  }
}
