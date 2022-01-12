import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/timer/timer.dart';

class TimerControls extends StatelessWidget {
  const TimerControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (previous, current) {
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is TimerInitial) ...[
              FloatingActionButton(
                onPressed: () async {
                  final duration = await showDurationPicker(
                    context: context,
                    initialTime:
                        const Duration(hours: 0, minutes: 0, seconds: 0),
                  );
                  if (duration != null && duration.inSeconds != 0) {
                    context.read<TimerBloc>().add(TimerDurationSet(duration));
                  }
                },
                child: const Icon(Icons.settings),
              )
            ],
            if (state is TimerSet) ...[
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerStarted());
                },
                child: const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerClearTime());
                },
                child: const Icon(Icons.stop),
              ),
            ],
            if (state is TimerRunInProgress) ...[
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerPaused());
                },
                child: const Icon(Icons.pause),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerRestarted());
                },
                child: const Icon(Icons.replay),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerClearTime());
                },
                child: const Icon(Icons.stop),
              ),
            ],
            if (state is TimerRunPause) ...[
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerResumed());
                },
                child: const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerRestarted());
                },
                child: const Icon(Icons.replay),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerClearTime());
                },
                child: const Icon(Icons.stop),
              ),
            ],
            if (state is TimerRunComplete) ...[
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerRestarted());
                },
                child: const Icon(Icons.replay),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerClearTime());
                },
                child: const Icon(Icons.stop),
              ),
            ]
          ],
        );
      },
    );
  }
}
