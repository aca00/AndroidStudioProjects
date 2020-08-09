part of 'counter_bloc.dart';

abstract class CounterState extends Equatable {
  final String msgState;
  const CounterState({this.msgState});
}

class CounterInitialState extends CounterState {
  CounterInitialState() : super(msgState: 'Initial State');
  List<Object> get props => [];
  @override
  String toString() => 'Initialo: $msgState';
}

class CounterIncrementState extends CounterState {
  CounterIncrementState() : super(msgState: 'Increment');
  List<Object> get props => [msgState];
  @override
  String toString() => 'Initialo: $msgState';
}

class CounterDecrementState extends CounterState {
  CounterDecrementState() : super(msgState: 'Decrement');
  List<Object> get props => [];
  @override
  String toString() => 'Initialo: $msgState';
}
