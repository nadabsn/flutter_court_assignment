import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_assignment_flutter/core/helpers/date_helper.dart';

void main() {
  group('Date Helper Tests', () {
    group('parseTime', () {
      test('should parse valid time string correctly', () {
        const timeString = '14:30';
        
        final result = parseTime(timeString);
        

        expect(result.hour, 14);
        expect(result.minute, 30);
      });

    });

    group('isSameDay', () {
      test('should return true for same date and time', () {
        // Arrange
        final date1 = DateTime(2024, 1, 15, 10, 30);
        final date2 = DateTime(2024, 1, 15, 10, 30);
        
        final result = isSameDay(date1, date2);
        
        expect(result, true);
      });


    });
  });
}
