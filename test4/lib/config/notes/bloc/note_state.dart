part of 'note_bloc.dart';

class NoteState {
  List db;
  int itemCount;
  NoteState({List db, int itemCount}) {
    this.db = db;
    this.itemCount = itemCount;
  }
}
