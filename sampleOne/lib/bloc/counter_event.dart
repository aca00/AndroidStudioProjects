part of 'counter_bloc.dart';
/// Reason why [countVal] is defined in each child class is because we pass value 
/// of integer corresponding to current state to  event from main.dart, and we 
/// have to obtain this value in order to pass it to corresponding state.
/// see [counter_bloc.dart]

@immutable
abstract class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {
  final int countVal;
  CounterIncrementEvent(this.countVal);
}

class CounterDecrementEvent extends CounterEvent {
  final int countVal;
  CounterDecrementEvent(this.countVal);
}
