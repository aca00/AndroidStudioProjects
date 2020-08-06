part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {
  //final String msg;
  const CounterEvent();
}

class CounterIncrementEvent extends CounterEvent {
  //CounterIncrementEvent() : super();
}

class CounterDecrementEvent extends CounterEvent {
  //CounterDecrementEvent() : super();
}
