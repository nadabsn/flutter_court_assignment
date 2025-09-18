import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/timer_model.dart';

/**
    Why Provider ?
    Provider is a good choice for this project because:

    Simplicity: Less boilerplate than BLoC for this scope
    Performance: Efficient rebuilds with Consumer widgets
    Flexibility: Easy to combine with ChangeNotifier for reactive state
 **/

class TimerProvider extends ChangeNotifier {
  final List<TimerModel> _timers = [
    TimerModel(
      id: '1',
      description: 'Design Review',
      project: 'Project A',
      task: 'UI/UX Design',
      isFavorite: true,
      startTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      elapsed: const Duration(hours: 1, minutes: 30),
      status: TimerStatus.stopped,
    ),
    TimerModel(
      id: '2',
      description: 'Design Review',
      project: 'Project B',
      task: 'UI/UX Design',
      isFavorite: false,
      startTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      elapsed: const Duration(hours: 1, minutes: 30),
      status: TimerStatus.stopped,
    ),
  ];
  final _uuid = Uuid();

  List<TimerModel> get timers => List.unmodifiable(_timers);

  Timer? _activeTimer;
  String? _activeTimerId;

  // Create a new timer with the given parameters
  void addTimer({
    required String description,
    required String project,
    required String task,
    required bool isFavorite,
  }) {
    final newTimer = TimerModel(
      id: _uuid.v4(),
      description: description,
      project: project,
      task: task,
      isFavorite: isFavorite,
      startTime: DateTime.now(),
      elapsed: Duration.zero,
      status: TimerStatus.running,
    );

    _timers.add(newTimer);
    // Automatically start the new timer
    startTimer(newTimer.id);
    notifyListeners();
  }

  // Start the timer with the given ID
  void startTimer(String id) {
    final timer = _timers.firstWhere((t) => t.id == id);
    timer.status = TimerStatus.running;
    _activeTimerId = id;

    _activeTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      timer.elapsed += const Duration(seconds: 1);
      notifyListeners();
    });
    notifyListeners();
  }

  // Pause the timer with the given ID
  void pauseTimer(String id) {
    if (_activeTimerId != id) return;

    _activeTimer?.cancel();
    final timer = _timers.firstWhere((t) => t.id == id);
    timer.status = TimerStatus.paused;

    _activeTimer = null;
    _activeTimerId = null;
    notifyListeners();
  }

  // Toggle the timer status based on its current state
  void toggleTimer(String id) {
    final timer = _timers.firstWhere((t) => t.id == id);
    if (timer.status == TimerStatus.running) {
      pauseTimer(id);
    } else if (timer.status == TimerStatus.paused ||
        timer.status == TimerStatus.stopped) {
      startTimer(id);
    }
    notifyListeners();
  }

  // Stop the timer with the given ID
  void stopTimer(String id) {
    if (_activeTimerId == id) {
      _activeTimer?.cancel();
      _activeTimer = null;
      _activeTimerId = null;
    }

    final timer = _timers.firstWhere((t) => t.id == id);
    timer.status = TimerStatus.stopped;
    timer.elapsed = Duration.zero;
    timer.startTime = null;

    notifyListeners();
  }

  // Get a timer by its ID
  TimerModel? getTimerById(String id) {
    return _timers.firstWhere((t) => t.id == id);
  }
}
