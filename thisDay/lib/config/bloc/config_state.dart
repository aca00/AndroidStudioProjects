part of 'config_bloc.dart';

class ConfigState {
  int date;
  String month;
  int priority = 0;
  ConfigState({int date, String month, int priority}) {
    this.date = date;
    this.month = month;
    this.priority = priority;
  }
}

class ConfigInitial extends ConfigState {}
