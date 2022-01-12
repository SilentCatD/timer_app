import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/app.dart';
import 'package:timer_app/timer_app_bloc_observer.dart';
void main() {
  BlocOverrides.runZoned(
    () => runApp(const TimerApp()),
    blocObserver: TimerAppBlocObserver(),
  );
}

