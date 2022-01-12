import 'package:flutter/material.dart';
import 'package:timer_app/timer/view/widgets/widgets.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Count Down Timer"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const BackGround(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: TimerText()),
              ),
              TimerControls(),
            ],
          ),
        ],
      ),
    );
  }
}
