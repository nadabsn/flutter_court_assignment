import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_assignment_flutter/core/common/widgets/custom_loader.dart';

import '../../../core/config/app_responsive_config.dart';
import '../../../core/utils/app_colors.dart';
import '../../bookings/models/court.dart';
import '../../bookings/providers/booking_provider.dart';
import '../models/facility.dart';
import '../widgets/booking_summary_widget.dart';
import '../widgets/courts_section_widget.dart';
import '../widgets/date_selection_widget.dart';
import '../widgets/facility_header_widget.dart';
import '../widgets/facility_info_widget.dart';
import '../widgets/time_selection_widget.dart';

class FacilityDetailsScreen extends StatefulWidget {
  final Facility facility;

  const FacilityDetailsScreen({
    super.key,
    required this.facility,
  });

  @override
  State<FacilityDetailsScreen> createState() => _FacilityDetailsScreenState();
}

class _FacilityDetailsScreenState extends State<FacilityDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize booking data for this facility
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().initializeForFacility(widget.facility.id);
    });
  }

  void _onCourtSelected(Court court) {
    context.read<BookingProvider>().selectCourt(court);
  }

  Future<void> _onDateSelected() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accent,
              onPrimary: AppColors.background,
              surface: AppColors.card,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (mounted && picked != null) {
      context.read<BookingProvider>().selectDate(picked);
    }
  }

  void _onTimeSelected(TimeOfDay time) {
    context.read<BookingProvider>().selectTime(time);
  }

  Future<void> _createBooking() async {
    final provider = context.read<BookingProvider>();
    final success = await provider.createBooking(widget.facility);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking created successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'View',
            textColor: Colors.white,
            onPressed: () {
              context.push('/bookings');
            },
          ),
        ),
      );
    } else if (!success && mounted) {
      final errorMessage = provider.errorMessage.isNotEmpty
          ? provider.errorMessage
          : 'Failed to create booking. Please try again.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () {
              context.read<BookingProvider>().clearError();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientBgStart, AppColors.gradientBgEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button
              FacilityHeaderWidget(
                facilityName: widget.facility.name,
                onBackPressed: () => Navigator.of(context).pop(),
              ),

              // Content
              Expanded(
                child: Consumer<BookingProvider>(
                  builder: (context, bookingProvider, child) {
                    if (bookingProvider.isLoading) {
                      return CustomLoader();
                    }

                    if (bookingProvider.errorMessage.isNotEmpty) {
                      return _buildErrorState(bookingProvider);
                    }

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Facility Info
                          FacilityInfoWidget(facility: widget.facility),
                          SizedBox(height: 24.h),

                          // Courts Section
                          CourtsSectionWidget(
                            courts: widget.facility.courts,
                            selectedCourt: bookingProvider.selectedCourt,
                            onCourtSelected: _onCourtSelected,
                          ),
                          SizedBox(height: 24.h),

                          // Date Selection
                          if (bookingProvider.selectedCourt != null) ...[
                            DateSelectionWidget(
                              selectedDate: bookingProvider.selectedDate,
                              onDateTap: _onDateSelected,
                            ),
                            SizedBox(height: 24.h),
                          ],

                          // Time Selection
                          if (bookingProvider.selectedDate != null &&
                              bookingProvider.selectedCourt != null) ...[
                            TimeSelectionWidget(
                              allTimeSlots: bookingProvider.allTimeSlots,
                              availableTimeSlots:
                                  bookingProvider.availableTimeSlots,
                              selectedStartTime:
                                  bookingProvider.selectedStartTime,
                              onTimeSelected: _onTimeSelected,
                            ),
                            SizedBox(height: 32.h),
                          ],

                          // Booking Summary and Book Button
                          if (bookingProvider.canCreateBooking) ...[
                            BookingSummaryWidget(
                              court: bookingProvider.selectedCourt!,
                              selectedDate: bookingProvider.selectedDate!,
                              startTime: bookingProvider.selectedStartTime!,
                              isLoading: bookingProvider.isCreatingBooking,
                              onBookPressed: _createBooking,
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BookingProvider provider) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.w,
              color: AppColors.mutedWhite,
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load booking data',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              provider.errorMessage,
              style: const TextStyle(
                color: AppColors.mutedWhite,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () =>
                  provider.initializeForFacility(widget.facility.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.background,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
