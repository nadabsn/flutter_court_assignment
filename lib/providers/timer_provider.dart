import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/timer_model.dart';

class TimerProvider extends ChangeNotifier {
  final List<TimerModel> _timers = [];
  final _uuid = Uuid();

  List<TimerModel> get timers => List.unmodifiable(_timers);

  Timer? _activeTimer;
  String? _activeTimerId;

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
    );

    _timers.add(newTimer);
    notifyListeners();
  }

  void startTimer(String id) {
    _stopCurrentTimer();

    final timer = _timers.firstWhere((t) => t.id == id);
    timer.status = TimerStatus.running;
    _activeTimerId = id;

    _activeTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      timer.elapsed += const Duration(seconds: 1);
      notifyListeners();
    });

    notifyListeners();
  }

  void pauseTimer(String id) {
    if (_activeTimerId != id) return;

    _activeTimer?.cancel();
    final timer = _timers.firstWhere((t) => t.id == id);
    timer.status = TimerStatus.paused;

    _activeTimer = null;
    _activeTimerId = null;
    notifyListeners();
  }

  void stopTimer(String id) {
    if (_activeTimerId == id) {
      _activeTimer?.cancel();
      _activeTimer = null;
      _activeTimerId = null;
    }

    final timer = _timers.firstWhere((t) => t.id == id);
    timer.status = TimerStatus.stopped;
    notifyListeners();
  }

  void _stopCurrentTimer() {
    if (_activeTimer != null && _activeTimerId != null) {
      final timer = _timers.firstWhere((t) => t.id == _activeTimerId);
      timer.status = TimerStatus.paused;
      _activeTimer?.cancel();
      _activeTimer = null;
      _activeTimerId = null;
    }
  }

  TimerModel? getTimerById(String id) {
    return _timers.firstWhere((t) => t.id == id);
  }
}
