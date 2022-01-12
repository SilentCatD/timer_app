import 'dart:async';

class Ticker {
  /// A stream which emit an integer every second, this integer is the amount
  /// of seconds left in the countdown duration.
  Stream<int> tick(Duration duration) {
    final totalSec = duration.inSeconds;
    final tickStream = Stream.periodic(const Duration(seconds: 1), (x) {
      return totalSec - x - 1; // to emit 0 (sec), add -1
    }).take(totalSec);
    // take(totalSec) to stop the stream when emitted totalSec event
    return tickStream;
  }
}
