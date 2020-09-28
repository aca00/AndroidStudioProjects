import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../note_actions.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc({int itemCount, List<Note> noteList})
      : super(NoteState(noteList: noteList, itemCount: itemCount));

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is UpdateNoteListEvent) {
      yield* _mapSaveEvent();
    }
  }

  Stream<NoteState> _mapSaveEvent() async* {
    List<Note> noteList = await getNoteList();
    yield NoteState(noteList: noteList, itemCount: noteList.length);
  }
}
