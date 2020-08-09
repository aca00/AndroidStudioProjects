import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'themeld_event.dart';
part 'themeld_state.dart';

class ThemeldBloc extends Bloc<ThemeLightDarkEvent, ThemeLightDarkState> {
  ThemeldBloc() : super(ThemeLightDarkInitial());

  @override
  Stream<ThemeLightDarkState> mapEventToState(
    ThemeLightDarkEvent event,
  ) async* {
    if (event is ThemeLightDarkEvent) {
      yield ThemeChangedState();
    }
  }
}
