part of 'counter_bloc.dart';

abstract class CounterState {
  final int countNum;
  final String msgState;
  const CounterState({this.msgState, this.countNum});
}

class CounterInitialState extends CounterState {
  CounterInitialState() : super(msgState: 'Initial State');
  @override
  String toString() => 'Initialo: $msgState';
}

class CounterIncrementState extends CounterState {
  CounterIncrementState() : super(msgState: 'Increment');
  @override
  String toString() => 'Initialo: $msgState';
}

class CounterDecrementState extends CounterState {
  CounterDecrementState() : super(msgState: 'Decrement');
  @override
  String toString() => 'Initialo: $msgState';
}
