part of 'timer_bloc.dart';

abstract class TimerEvent {
  const TimerEvent();
}

class TimerDurationSet extends TimerEvent {
  final Duration duration;

  const TimerDurationSet(this.duration);
}

class TimerStarted extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final Duration duration;

  const TimerTicked(this.duration);
}

class TimerPaused extends TimerEvent {}

class TimerResumed extends TimerEvent {}

class TimerRestarted extends TimerEvent {}

class TimerClearTime extends TimerEvent {}
