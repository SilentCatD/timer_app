import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/timer/timer.dart';

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        final minutesString = (state.duration.inMinutes % 60).toString().padLeft(2, '0');
        final secondsString = (state.duration.inSeconds % 60).toString().padLeft(2, '0');
        final hoursString = state.duration.inHours.toString().padLeft(2, '0');
        return Text(
          "$hoursString:$minutesString:$secondsString",
          style: Theme.of(context).textTheme.headline2,
        );
      },
    );
  }
}
