import 'package:flutter/material.dart';

import '../../../core/common/models/booking.dart';
import '../../../core/common/models/court.dart';
import '../../../core/common/models/facility.dart';
import '../service/booking_service.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService;

  BookingProvider(this._bookingService);

  // State
  Court? _selectedCourt;
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  List<TimeOfDay> _availableTimeSlots = [];
  List<Booking> _existingBookings = [];
  bool _isLoading = false;
  bool _isCreatingBooking = false;
  String _errorMessage = '';
  List<Booking> _userBookings = [];

  // Getters
  Court? get selectedCourt => _selectedCourt;

  DateTime? get selectedDate => _selectedDate;

  TimeOfDay? get selectedStartTime => _selectedStartTime;

  List<TimeOfDay> get availableTimeSlots => _availableTimeSlots;

  List<Booking> get existingBookings => _existingBookings;

  bool get isLoading => _isLoading;

  bool get isCreatingBooking => _isCreatingBooking;

  String get errorMessage => _errorMessage;

  List<Booking> get userBookings => _userBookings;

  bool get canCreateBooking =>
      _selectedCourt != null &&
      _selectedDate != null &&
      _selectedStartTime != null &&
      !_isCreatingBooking;

  // Public methods

  /// Initialize booking data for a facility
  Future<void> initializeForFacility(String facilityId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _existingBookings = await _bookingService.getBookings();
      _existingBookings = _existingBookings
          .where((booking) => booking.facilityId == facilityId)
          .toList();
    } catch (e) {
      _errorMessage = 'Failed to load existing bookings: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Select a court
  void selectCourt(Court court) {
    _selectedCourt = court;
    _selectedStartTime = null; // Reset time selection
    _availableTimeSlots = [];
    _errorMessage = '';

    // Generate time slots if date is already selected
    if (_selectedDate != null) {
      _generateAvailableTimeSlots();
    }

    notifyListeners();
  }

  /// Select a date
  void selectDate(DateTime date) {
    _selectedDate = date;
    _selectedStartTime = null; // Reset time selection
    _availableTimeSlots = [];
    _errorMessage = '';

    // Generate time slots if court is already selected
    if (_selectedCourt != null) {
      _generateAvailableTimeSlots();
    }

    notifyListeners();
  }

  /// Select a time
  void selectTime(TimeOfDay time) {
    _selectedStartTime = time;
    _errorMessage = '';
    notifyListeners();
  }

  /// Generate available time slots
  Future<void> _generateAvailableTimeSlots() async {
    if (_selectedCourt == null || _selectedDate == null) {
      _availableTimeSlots = [];
      return;
    }

    try {
      _availableTimeSlots = await _bookingService.getAvailableTimeSlots(
        facilityId: _selectedCourt!.id,
        // Assuming court has facility ID, or pass it separately
        courtId: _selectedCourt!.id,
        date: _selectedDate!,
        dailyOpen: _selectedCourt!.dailyOpen,
        dailyClose: _selectedCourt!.dailyClose,
        slotMinutes: _selectedCourt!.slotMinutes,
      );
    } catch (e) {
      _errorMessage = 'Failed to generate time slots: $e';
      _availableTimeSlots = [];
    }

    notifyListeners();
  }

  /// Create a new booking
  Future<bool> createBooking(Facility facility) async {
    if (!canCreateBooking) return false;

    _isCreatingBooking = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final court = _selectedCourt!;
      final startMinutes =
          _selectedStartTime!.hour * 60 + _selectedStartTime!.minute;
      final endMinutes = startMinutes + court.slotMinutes;

      final booking = Booking(
        id: 'booking_${DateTime.now().millisecondsSinceEpoch}',
        facilityId: facility.id,
        courtId: court.id,
        date: _selectedDate!,
        startTime: _selectedStartTime!,
        endTime: TimeOfDay(hour: endMinutes ~/ 60, minute: endMinutes % 60),
        facilityName: facility.name,
        courtLabel: court.label,
        price: court.price,
      );
      // Save to shared preferences
      await _bookingService.saveBooking(booking);

      // Add to local list
      _existingBookings.add(booking);

      // Reset selections
      clearSelections();

      // Refresh available slots if needed
      if (_selectedCourt != null && _selectedDate != null) {
        await _generateAvailableTimeSlots();
      }

      return true;
    } catch (e) {
      _errorMessage = 'Failed to create booking: $e';
      return false;
    } finally {
      _isCreatingBooking = false;
      notifyListeners();
    }
  }

  /// Get all user bookings
  Future<List<Booking>> getAllBookings() async {
    try {
      List<Booking> bookings = await _bookingService.getBookings();
      _userBookings = bookings;
      notifyListeners();
      return _userBookings;
    } catch (e) {
      _errorMessage = 'Failed to load bookings: $e';
      return [];
    }
  }

  /// Cancel a booking
  Future<bool> cancelBooking(String bookingId) async {
    try {
      await _bookingService.deleteBooking(bookingId);

      // Remove from local list
      _existingBookings.removeWhere((booking) => booking.id == bookingId);

      // Refresh available slots if needed
      if (_selectedCourt != null && _selectedDate != null) {
        await _generateAvailableTimeSlots();
      }

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to cancel booking: $e';
      return false;
    }
  }

  /// Clear all selections
  void clearSelections() {
    _selectedCourt = null;
    _selectedDate = null;
    _selectedStartTime = null;
    _availableTimeSlots = [];
    _errorMessage = '';
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  /// Refresh booking data
  Future<void> refreshBookings(String facilityId) async {
    await initializeForFacility(facilityId);
  }

  /// Check if a time slot is available
  Future<bool> isTimeSlotAvailable({
    required String facilityId,
    required String courtId,
    required DateTime date,
    required TimeOfDay startTime,
    required int slotMinutes,
  }) async {
    try {
      final hasConflict = await _bookingService.hasTimeSlotConflict(
        facilityId: facilityId,
        courtId: courtId,
        date: date,
        startTime: startTime,
        slotMinutes: slotMinutes,
      );
      return !hasConflict;
    } catch (e) {
      return false;
    }
  }
}
