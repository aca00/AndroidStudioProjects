import 'dart:async';

import 'package:bloc/bloc.dart';

part 'change_event.dart';
part 'change_state.dart';

class ChangeBloc extends Bloc<ChangeEvent, ChangeState> {
  ChangeBloc({int sortCategory, int sortOrder})
      : super(ChangeState(sortCategory: sortCategory, sortOrder: sortOrder));

  @override
  Stream<ChangeState> mapEventToState(
    ChangeEvent event,
  ) async* {
    if (event is ChangeEvent) {
      yield ChangeState(
          sortCategory: event.sortCategory, sortOrder: event.sortOrder);
    }
  }
}

class UpdateEventsInsideStoryBloc
    extends Bloc<UpdateEventsInsideStoryEvent, UpdateEventsInsideStoryState> {
  UpdateEventsInsideStoryBloc() : super(UpdateEventsInsideStoryState());
  @override
  Stream<UpdateEventsInsideStoryState> mapEventToState(
    UpdateEventsInsideStoryEvent event,
  ) async* {
    if (event is UpdateEventsInsideStoryEvent) {
      yield UpdateEventsInsideStoryState();
    }
  }
}
