import 'dart:async';

class TimerService {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  bool isRunning = false;

  void startTimer(Function(int) onTick) {
    if (!isRunning) {
      _stopwatch.start();
      isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        onTick(_stopwatch.elapsed.inSeconds);
      });
    }
  }

  void pauseTimer() {
    if (isRunning) {
      _stopwatch.stop();
      isRunning = false;
    }
  }

  int stopTimer() {
    if (isRunning) {
      _stopwatch.stop();
      isRunning = false;
    }
    final elapsedSeconds = _stopwatch.elapsed.inSeconds;
    _stopwatch.reset();
    return elapsedSeconds;
  }

  void dispose() {
    _timer?.cancel();
  }
}
