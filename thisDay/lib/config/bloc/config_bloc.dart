import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:thisDay/config/theme_data.dart';
part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(ConfigState(priority: 0));

  @override
  Stream<ConfigState> mapEventToState(
    ConfigEvent event,
  ) async* {
    if (event is TheChangeEvent) {
      yield* _mapMonthChangeEvent(event.month, event.date, event.priority);
    }
  }

  Stream<ConfigState> _mapMonthChangeEvent(
      String month, int date, int priority) async* {
    int newPriority = (priority + 1) % priorityColorsListItems;
    yield ConfigState(month: month, date: date, priority: newPriority);
  }
}
