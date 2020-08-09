import 'dart:async';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  static const int _initialCount = 0;
  CounterBloc() : super(CounterInitialState(_initialCount));

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is CounterIncrementEvent) {
      /// Here we first obtain [countVal] from[CounterIncrementEvent] which was
      /// supplied from main ui by counterBloc.add method. We then pass this 
      /// value+1 to [CounterIncrementState]. [CouterIncrementState] then passes
      /// this value to its parent class, which is then called by BlocBuilder to 
      /// build new state. 
      yield CounterIncrementState(event.countVal + 1);
    }
    if (event is CounterDecrementEvent) {
      yield CounterDecrementState(event.countVal - 1);
    }
  }
}
