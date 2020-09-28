import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test4/config/database_helper.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc({List db, int itemCount})
      : super(NoteState(db: db, itemCount: itemCount));

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is UpdateNoteListEvent) {
      yield* _mapSaveEvent();
    }
  }

  Stream<NoteState> _mapSaveEvent() async* {
    List db = await DatabaseHelper.instance.queryAll();
    int itemCount = db.length;
    yield NoteState(db: db, itemCount: itemCount);
  }
}
