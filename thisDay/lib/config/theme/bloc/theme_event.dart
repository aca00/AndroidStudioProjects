part of 'theme_bloc.dart';

abstract class ThemeEvent {}

/// In BrightnessChangedEvent we have to define a boolean object. This bool value
/// is passed to mapEventToState function in theme_bloc.dart to build theme state.
/// Basically this must respond to the current state of switch  which gives 
/// darkmode
class BrightnessChangedEvent extends ThemeEvent {
  bool darkModeBoolCheck;
  BrightnessChangedEvent(value) {
    this.darkModeBoolCheck = value;
  }
}

class AccentColorChangedEvent extends ThemeEvent {
  AccentColorChangedEvent();
}
