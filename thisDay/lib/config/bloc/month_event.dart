part of 'month_bloc.dart';


abstract class MonthEvent {}

class MonthChangeEvent extends MonthEvent {
  int val;
  MonthChangeEvent(this.val);
}
