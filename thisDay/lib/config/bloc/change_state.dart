part of 'change_bloc.dart';

class ChangeState {
  int sortCategory;
  int sortOrder;
  ChangeState({this.sortCategory, this.sortOrder});
}



class ChangeInitial extends ChangeState {}

class UpdateEventsInsideStoryState {
  bool check = false;
  UpdateEventsInsideStoryState() {
    this.check = !this.check;
  }
}
