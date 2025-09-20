import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_assignment_flutter/features/bookings/models/booking.dart';

void main() {
  group('Booking Model Tests', () {
    late Booking testBooking;
    late Map<String, dynamic> testBookingJson;

    setUp(() {
      testBooking = Booking(
        id: 'test-id-123',
        facilityId: 'facility-456',
        courtId: 'court-789',
        date: DateTime(2024, 1, 15),
        startTime: const TimeOfDay(hour: 10, minute: 30),
        endTime: const TimeOfDay(hour: 11, minute: 30),
        facilityName: 'Test Sports Center',
        courtLabel: 'Court 1',
        price: 25.50,
      );

      testBookingJson = {
        'id': 'test-id-123',
        'facilityId': 'facility-456',
        'courtId': 'court-789',
        'date': '2024-01-15T00:00:00.000',
        'startTime': '10:30',
        'endTime': '11:30',
        'facilityName': 'Test Sports Center',
        'courtLabel': 'Court 1',
        'price': 25.50,
      };
    });

    group('fromJson', () {
      test('should create booking from json correctly', () {
        // Act
        final booking = Booking.fromJson(testBookingJson);

        // Assert
        expect(booking.id, 'test-id-123');
        expect(booking.facilityId, 'facility-456');
        expect(booking.courtId, 'court-789');
        expect(booking.date, DateTime(2024, 1, 15));
        expect(booking.startTime.hour, 10);
        expect(booking.startTime.minute, 30);
        expect(booking.endTime.hour, 11);
        expect(booking.endTime.minute, 30);
        expect(booking.facilityName, 'Test Sports Center');
        expect(booking.courtLabel, 'Court 1');
        expect(booking.price, 25.50);
      });

     
  });
});
}
