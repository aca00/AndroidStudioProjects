import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import '../../theme_data.dart';
import '../../user_preferences.dart';
part 'theme_event.dart';
part 'theme_state.dart';

/// ThemeBloc responds to two events.
///   1. User changes the accent color
///   2. User changes the brightness
/// Theme is built using two parameters.
///   1. A boolean value which determine whether it is dark mode or not.
///   2. A int value which determines the index of list of accent colors.
/// Both of these values passed from main.dart
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({bool darkBoolCheck, int accentColorCount})
      : super(ThemeState(
            darkBoolCheck: darkBoolCheck, accentColorCount: accentColorCount));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is BrightnessChangedEvent) {
      yield* _mapChangedEvent(event.darkModeBoolCheck);
    } else if (event is AccentColorChangedEvent) {
      yield* _mapColorChanged();
    }
  }

  /// Firstly, save the current darkModeBoolCheck boolean then load savedAccentColorCount
  /// both of them are passed to theme state to build theme
  Stream<ThemeState> _mapChangedEvent(val) async* {
    await saveDarkModeBool(val);
    int savedAccentColorCount = await loadAccentColorCount();
    yield ThemeState(
        darkBoolCheck: val, accentColorCount: savedAccentColorCount);
  }

  /// DarkBool saved is loaded first. Accent color is picked from a list of
  /// available colors. Each time user presses the accent color list tile, one
  /// of the available color is selected. After the final color is selected this
  /// must be set to initial color. This is what % operator do.
  Stream<ThemeState> _mapColorChanged() async* {
    bool savedDarkBool = await loadDarkModeBool();
    int currentAccentColorCount = await loadAccentColorCount();
    int newAccentColorCount = (currentAccentColorCount + 1) % listItems;
    await saveAccentInt(newAccentColorCount);
    yield ThemeState(
        darkBoolCheck: savedDarkBool, accentColorCount: newAccentColorCount);
  }
}
