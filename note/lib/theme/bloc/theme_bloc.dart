import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:note/config/config.dart';
import 'package:note/theme/theme_data.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(val) : super(ThemeState(val));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeEvent) {
      yield* _mapEventToState();
    }
  }

  Stream<ThemeState> _mapEventToState() async* {
    bool currentVal = await config.loadBool();
    bool newVal = !currentVal;
    await config.saveBool(newVal);
    yield ThemeState(newVal);
  }
}
