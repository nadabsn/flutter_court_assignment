import 'package:flutter_test/flutter_test.dart';
import 'package:test_assignment_flutter/features/bookings/models/court.dart';

void main() {
  group('Court Model Tests', () {
    group('fromJson', () {
      test('should create court from complete json correctly', () {
        final json = {
          'id': 'court-123',
          'sport': 'Tennis',
          'label': 'Court 1',
          'price': 30.0,
          'slotMinutes': 90,
          'dailyOpen': '08:00',
          'dailyClose': '22:00',
        };

        final court = Court.fromJson(json);

        expect(court.id, 'court-123');
        expect(court.sport, 'Tennis');
        expect(court.label, 'Court 1');
        expect(court.price, 30.0);
        expect(court.slotMinutes, 90);
        expect(court.dailyOpen, '08:00');
        expect(court.dailyClose, '22:00');
      });


    });

  });
}
