import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/ticker.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  late Ticker _ticker;
  Duration? _lastDuration;
  StreamSubscription? _tickerStreamSubscription;

  TimerBloc(Ticker ticker) : super(const TimerInitial()) {
    _ticker = ticker;
    on<TimerDurationSet>(_onTimerDurationSet);
    on<TimerStarted>(_onTimerStarted);
    on<TimerTicked>(_onTimerTicked);
    on<TimerClearTime>(_onTimerClearTime);
    on<TimerPaused>(_onTimerPaused);
    on<TimerResumed>(_onTimerResumed);
    on<TimerRestarted>(_onTimerRestarted);
  }

  void _onTimerPaused(TimerPaused event, Emitter emit) {
    _tickerStreamSubscription!.pause();
    final currentState = state as TimerRunInProgress;
    emit(TimerRunPause(currentState.duration));
  }

  void _onTimerResumed(TimerResumed event, Emitter emit) {
    final currentState = state as TimerRunPause;
    emit(TimerRunInProgress(currentState.duration));
    _tickerStreamSubscription!.resume();
  }

  void _onTimerTicked(TimerTicked event, Emitter emit) {
    if (event.duration.inSeconds == 0) {
      emit(TimerRunComplete(event.duration));
    } else {
      emit(TimerRunInProgress(event.duration));
    }
  }

  void _onTimerRestarted(TimerRestarted event, Emitter emit) {
    add(TimerStarted());
  }

  void _onTimerStarted(TimerStarted event, Emitter emit) {
    add(TimerTicked(_lastDuration!));
    _tickerStreamSubscription?.cancel();
    _tickerStreamSubscription = _monitorTicker(_lastDuration!);
  }

  void _onTimerClearTime(TimerClearTime event, Emitter emit) {
    _lastDuration = null;
    _tickerStreamSubscription?.cancel();
    emit(const TimerInitial());
  }

  void _onTimerDurationSet(TimerDurationSet event, Emitter emit) {
    _lastDuration = event.duration;
    emit(TimerSet(event.duration));
  }

  StreamSubscription _monitorTicker(Duration duration) {
    return _ticker.tick(duration).listen((tick) {
      add(TimerTicked(Duration(seconds: tick)));
    });
  }

  @override
  Future<void> close() {
    _tickerStreamSubscription?.cancel();
    return super.close();
  }
}
