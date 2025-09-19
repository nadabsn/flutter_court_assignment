import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/common/models/booking.dart';
import '../../../core/helpers/date_helper.dart';
import '../../../core/services/storage_service.dart';

class BookingService {
  static const String _bookingsKey = 'saved_bookings';
  final LocalStorageService _localStorage = LocalStorageService();


  /// Save a new booking to shared preferences
  Future<void> saveBooking(Booking booking) async {
    try {
      final List<Booking> existingBookings = await getBookings();

      existingBookings.add(booking);

      final List<String> bookingsJson = existingBookings
          .map((booking) => json.encode(booking.toJson()))
          .toList();

      await _localStorage.setBookings(bookingsJson);
    } catch (e) {
      throw Exception('Failed to save booking: $e');
    }
  }

  /// Get all bookings from shared preferences
  Future<List<Booking>> getBookings() async {
    try {
      final List<String>? bookingsJson = await _localStorage.getBookings();

      if (bookingsJson == null || bookingsJson.isEmpty) {
        return [];
      }

      return bookingsJson.map((jsonString) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return Booking.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load bookings: $e');
    }
  }

  /// Get bookings for a specific facility, court, and date
  Future<List<Booking>> getBookingsForCourtAndDate(String facilityId,
      String courtId, DateTime date) async {
    final allBookings = await getBookings();

    return allBookings
        .where((booking) =>
    booking.facilityId == facilityId &&
        booking.courtId == courtId &&
        isSameDay(booking.date, date))
        .toList();
  }

  /// Delete a booking by ID
  Future<void> deleteBooking(String bookingId) async {
    try {
      final List<Booking> bookings = await getBookings();

      bookings.removeWhere((booking) => booking.id == bookingId);

      final List<String> bookingsJson =
      bookings.map((booking) => json.encode(booking.toJson())).toList();

      await _localStorage.setBookings(bookingsJson);
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }

  /// Check if a time slot conflicts with existing bookings
  Future<bool> hasTimeSlotConflict({
    required String facilityId,
    required String courtId,
    required DateTime date,
    required TimeOfDay startTime,
    required int slotMinutes,
  }) async {
    final existingBookings =
    await getBookingsForCourtAndDate(facilityId, courtId, date);

    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = startMinutes + slotMinutes;

    for (final booking in existingBookings) {
      final bookingStartMinutes =
          booking.startTime.hour * 60 + booking.startTime.minute;
      final bookingEndMinutes =
          booking.endTime.hour * 60 + booking.endTime.minute;

      // Check for overlap: Start < ExistingEnd AND ExistingStart < End
      if (startMinutes < bookingEndMinutes &&
          bookingStartMinutes < endMinutes) {
        return true;
      }
    }

    return false;
  }

  /// Generate available time slots for a court on a specific date
  Future<List<TimeOfDay>> getAvailableTimeSlots({
    required String facilityId,
    required String courtId,
    required DateTime date,
    required String dailyOpen,
    required String dailyClose,
    required int slotMinutes,
  }) async {
    final openTime = parseTime(dailyOpen);
    final closeTime = parseTime(dailyClose);

    List<TimeOfDay> allSlots = [];
    // Generate 30-minute intervals from open to close
    int currentMinutes = openTime.hour * 60 + openTime.minute;
    final closeMinutes = closeTime.hour * 60 + closeTime.minute;

    while (currentMinutes + slotMinutes <= closeMinutes) {
      allSlots.add(TimeOfDay(
        hour: currentMinutes ~/ 60,
        minute: currentMinutes % 60,
      ));
      currentMinutes += 30; // 30-minute grid
    }

    // Filter out conflicting time slots
    List<TimeOfDay> availableSlots = [];

    for (final slot in allSlots) {
      try {
        final hasConflict = await hasTimeSlotConflict(
          facilityId: facilityId,
          courtId: courtId,
          date: date,
          startTime: slot,
          slotMinutes: slotMinutes,
        );
        if (!hasConflict) {
          availableSlots.add(slot);
        } else {
          //
          print("Slot $slot has conflict, skipping");
        }
      } catch (e) {
        continue; // Skip this slot on error
      }
    }
    return availableSlots;
  }

  List<TimeOfDay> getAllTimeSlots({
    required String dailyOpen,
    required String dailyClose,
    required int slotMinutes,
  }) {
    final openTime = parseTime(dailyOpen);
    final closeTime = parseTime(dailyClose);

    List<TimeOfDay> allSlots = [];

    int currentMinutes = openTime.hour * 60 + openTime.minute;
    final closeMinutes = closeTime.hour * 60 + closeTime.minute;

    while (currentMinutes + slotMinutes <= closeMinutes) {
      allSlots.add(TimeOfDay(
        hour: currentMinutes ~/ 60,
        minute: currentMinutes % 60,
      ));
      currentMinutes += 30; // 30-minute grid
    }

    return allSlots;
  }
}
