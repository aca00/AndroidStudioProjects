import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sampleOne/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  
  CounterBloc(int val) : super(CounterInitialState(val));

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
      yield* _mapIncrementEvent(event.countVal);
    }
    if (event is CounterDecrementEvent) {
      yield* _mapDecrementEvent(event.countVal);
    }
  }
}

Stream<CounterState> _mapIncrementEvent(val) async* {
  Config config = Config();
  await config.saveCounterData(val + 1);
  yield CounterIncrementState(val + 1);
}

Stream<CounterState> _mapDecrementEvent(val) async* {
  Config config = Config();
  await config.saveCounterData(val - 1);
  yield CounterDecrementState(val - 1);
}
