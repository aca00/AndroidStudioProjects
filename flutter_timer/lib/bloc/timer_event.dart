import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Our TimerBloc will need to know how to process the following events:

//     TimerStarted — informs the TimerBloc that the timer should be started.
//     TimerPaused — informs the TimerBloc that the timer should be paused.
//     TimerResumed — informs the TimerBloc that the timer should be resumed.
//     TimerReset — informs the TimerBloc that the timer should be reset to the
//        original state.
//     TimerTicked — informs the TimerBloc that a tick has occurred and that
//      it needs to update its state accordingly.

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStartedEvent extends TimerEvent {
  final int duration;

  const TimerStartedEvent({@required this.duration});

  @override
  String toString() => "TimerStarted { duration: $duration }";
}

class TimerPausedEvent extends TimerEvent {}

class TimerResumedEvent extends TimerEvent {}

class TimerResetEvent extends TimerEvent {}

class TimerTickedEvent extends TimerEvent {
  final int duration;

  const TimerTickedEvent({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "TimerTicked { duration: $duration }";
}
