part of 'counter_bloc.dart';


/// Only parent class which is [CounterState] here, is used to build state using 
/// bloc builder. So in order to change state, the 'ChangedState' class must send 
/// necessary parameters to its parent Counter State. In this case [countValue] in 
/// parent class is modified by its child class whenever they are called. */

@immutable
abstract class CounterState {
  final int countValue;
  CounterState(this.countValue);
 
}

class CounterInitialState extends CounterState {
  CounterInitialState(int countValue) : super(countValue);
}

class CounterIncrementState extends CounterState {
  CounterIncrementState(int countValue) : super(countValue);
}

class CounterDecrementState extends CounterState {
  CounterDecrementState(int countValue) : super(countValue);
}
