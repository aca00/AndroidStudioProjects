part of 'config_bloc.dart';

abstract class ConfigEvent {}

class TheChangeEvent extends ConfigEvent {
  String month;
  int date;
  int priority;
  TheChangeEvent(this.month, this.date, this.priority);
}

