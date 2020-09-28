part of 'note_bloc.dart';

class NoteState {
  Note note;
  List<Note> noteList;
  int itemCount;
  NoteState({List<Note> noteList, int itemCount}) {
    this.noteList = noteList;
    this.itemCount = itemCount;
  }
}
