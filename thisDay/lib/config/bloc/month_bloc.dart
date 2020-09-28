import 'dart:async';

import 'package:bloc/bloc.dart';


part 'month_event.dart';
part 'month_state.dart';

class MonthBloc extends Bloc<MonthEvent, MonthState> {
  MonthBloc({int month}) : super(MonthState(val: month));

  @override
  Stream<MonthState> mapEventToState(
    MonthEvent event,
  ) async* {
    if (event is MonthChangeEvent) {
      yield* _mapMonthChangeEvent(event.val);
    }
  }

  Stream<MonthState> _mapMonthChangeEvent(int val) async* {
    yield MonthState(val: val);
  }
}
