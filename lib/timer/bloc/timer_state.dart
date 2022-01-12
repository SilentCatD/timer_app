part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final Duration duration;

  const TimerState(this.duration);

  @override
  List<Object?> get props => [duration];
}

/// In the future, there will be timer not set and timer set state

/// Timer is not set yet
class TimerInitial extends TimerState {
  const TimerInitial() : super(const Duration(minutes: 0, seconds: 0));
}

/// TimerSetComplete
class TimerSet extends TimerState {
  const TimerSet(Duration duration) : super(duration);
}

/// Timer is running
class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(Duration duration) : super(duration);
}

/// Timer is paused
class TimerRunPause extends TimerState {
  const TimerRunPause(Duration duration) : super(duration);
}

/// Timer running is completed
class TimerRunComplete extends TimerState {
  const TimerRunComplete(Duration duration) : super(duration);
}
