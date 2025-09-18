import 'package:flutter/material.dart';

/**
 * Utility functions for formatting date-time values.
 */

TimeOfDay parseTime(String timeString) {
  final parts = timeString.split(':');
  return TimeOfDay(
    hour: int.parse(parts[0]),
    minute: int.parse(parts[1]),
  );
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
