import 'package:bloc/bloc.dart';
import 'package:flutter_timer/bloc/bloc.dart';
import 'package:flutter_timer/ticker.dart';
import 'dart:async';
import 'package:meta/meta.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  // The first thing we need to do is define the initial state of our TimerBloc.
  // In this case, we want the TimerBloc to start off in the TimerInitial state
  // with a preset duration of 1 minute (60 seconds)
  static const int _duration = 60;
  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker,
        super(TimerInitialState(_duration));

  // If the TimerBloc receives a TimerStarted event, it pushes a
  // TimerRunInProgress state with the start duration.
  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStartedEvent) {
      yield* _mapTimerStartedToState(event);
    } else if (event is TimerTickedEvent) {
      yield* _mapTimerTickedToState(event);
    } else if (event is TimerPausedEvent) {
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerResumedEvent) {
      yield* _mapTimerResumedToState(event);
    } else if (event is TimerResetEvent) {
      yield* _mapTimerResetToState(event);
    }
  }

  // In addition, if there was already an open _tickerSubscription we need to
  // cancel it to deallocate the memory. We also need to override the close
  // method on our TimerBloc so that we can cancel the _tickerSubscription
  // when the TimerBloc is closed.
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  //  We listen to the _ticker.tick stream and on every tick we add
  // a TimerTicked event with the remaining duration.
  Stream<TimerState> _mapTimerStartedToState(TimerStartedEvent start) async* {
    yield TimerRunInProgressState(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TimerTickedEvent(duration: duration)));
  }

  // Every time a TimerTicked event is received, if the tick’s duration is
  // greater than 0, we need to push an updated TimerRunInProgress state with
  // the new duration. Otherwise, if the tick’s duration is 0, our timer has
  // ended and we need to push a TimerRunComplete state.
  Stream<TimerState> _mapTimerTickedToState(TimerTickedEvent tick) async* {
    yield tick.duration > 0
        ? TimerRunInProgressState(tick.duration)
        : TimerRunCompleteState();
  }

  // In _mapTimerPausedToState if the state of our TimerBloc is
  // TimerRunInProgress, then we can pause the _tickerSubscription and push a
  // TimerRunPause state with the current timer duration.
  Stream<TimerState> _mapTimerPausedToState(TimerPausedEvent pause) async* {
    if (state is TimerRunInProgressState) {
      _tickerSubscription?.pause();
      yield TimerRunPauseState(state.duration);
    }
  }

  // The TimerResumed event handler is very similar to the TimerPaused event
  // handler. If the TimerBloc has a state of TimerRunPause and it receives a
  // TimerResumed event, then it resumes the _tickerSubscription and pushes a
  // TimerRunInProgress state with the current duration.
  Stream<TimerState> _mapTimerResumedToState(TimerResumedEvent resume) async* {
    if (state is TimerRunPauseState) {
      _tickerSubscription?.resume();
      yield TimerRunInProgressState(state.duration);
    }
  }

  // If the TimerBloc receives a TimerReset event, it needs to cancel the
  // current _tickerSubscription so that it isn’t notified of any additional
  // ticks and pushes a TimerInitial state with the original duration.

  Stream<TimerState> _mapTimerResetToState(TimerResetEvent reset) async* {
    _tickerSubscription?.cancel();
    yield TimerInitialState(_duration);
  }
}
