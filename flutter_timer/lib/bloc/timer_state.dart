import 'package:equatable/equatable.dart';
// Our TimerBloc state can be one of the following:

//     TimerInitial — ready to start counting down from the specified duration.
//     TimerRunInProgress — actively counting down from the specified duration.
//     TimerRunPause — paused at some remaining duration.
//     TimerRunComplete — completed with a remaining duration of 0.

// Each of these states will have an implication on what the user sees. For example:

//     if the state is TimerInitial the user will be able to start the timer.
//     if the state is TimerRunInProgress the user will be able to pause and 
//     reset the timer as well as see the remaining duration.
//     if the state is TimerRunPause the user will be able to resume the timer 
//     and reset the timer.
//     if the state is TimerRunComplete the user will be able to reset the timer.

// All of the TimerStates extend the abstract base class TimerState
// which has a duration property. This is because no matter what state our
// TimerBloc is in, we want to know how much time is remaining.

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitialState extends TimerState {
  const TimerInitialState(int duration) : super(duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerRunPauseState extends TimerState {
  const TimerRunPauseState(int duration) : super(duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

class TimerRunInProgressState extends TimerState {
  const TimerRunInProgressState(int duration) : super(duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class TimerRunCompleteState extends TimerState {
  const TimerRunCompleteState() : super(0);
}
