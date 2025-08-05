import 'package:flutter/foundation.dart';

enum TimerStatus { running, paused, stopped }

class TimerModel {
  final String id;
  final String description;
  final String project;
  final String task;
  final bool isFavorite;
  final DateTime startTime;
  Duration elapsed;
  TimerStatus status;

  TimerModel({
    required this.id,
    required this.description,
    required this.project,
    required this.task,
    this.isFavorite = false,
    required this.startTime,
    this.elapsed = Duration.zero,
    this.status = TimerStatus.stopped,
  });

  void reset() {
    elapsed = Duration.zero;
    status = TimerStatus.stopped;
  }
}
