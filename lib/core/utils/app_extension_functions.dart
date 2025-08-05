/**
 * This file contains extension methods for the DateTime class to provide
 * additional functionality such as getting the day name and formatted date.
 */

extension DayNameExtension on DateTime {
  String get dayName {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday -
        1]; // DateTime.weekday returns 1 for Monday and 7 for Sunday
  }

  String get formattedDate {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year';
  }
}
