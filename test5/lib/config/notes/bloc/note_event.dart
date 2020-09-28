part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class UpdateNoteListEvent extends NoteEvent {}
