import 'dart:async';

import 'package:smart_care/features/study/bloc/StudyEvent.dart';

class Ticker {
  int tickTimingSec;
  Ticker({this.tickTimingSec=1});
  Stream<int> tick() {
    return Stream.periodic(Duration(seconds: tickTimingSec), (x) => x+1);
  }
}

class Timer {
  int tickTimingSec;
  int offset = 0;
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  Timer({this.tickTimingSec=1}): _ticker = Ticker(tickTimingSec:tickTimingSec);

  void start(void Function(int tickPeriod) onData) {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick().listen(onData);
  }

  void pause() {
    _tickerSubscription?.pause();
  }
  void resume() {
    _tickerSubscription?.resume();
  }
  void cancel() {
    _tickerSubscription?.cancel();
  }
}