/**
 * TimerModel class
 * This class represents a timer with properties such as id, description, project, task, and status.
 * TimerStatus enum defines the possible states of the timer.
 */
enum TimerStatus { running, paused, stopped }

class TimerModel {
  final String id;
  final String description;
  final String project;
  final String task;
  final bool isFavorite;
  DateTime? startTime;
  Duration elapsed;
  TimerStatus status;

  TimerModel({
    required this.id,
    required this.description,
    required this.project,
    required this.task,
    this.isFavorite = false,
    this.startTime,
    this.elapsed = Duration.zero,
    this.status = TimerStatus.stopped,
  });
}
