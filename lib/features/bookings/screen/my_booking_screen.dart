import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:test_assignment_flutter/core/common/models/booking.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_colors.dart';

import '../../../core/common/widgets/custom_loader.dart';
import '../../../core/common/widgets/empty_state.dart';
import '../../../core/helpers/snackbar_helper.dart';
import '../../../core/utils/app_text_styles.dart';
import '../providers/booking_provider.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBookings();
    });
  }

  Future<void> _loadBookings() async {
    try {
      final bookingProvider =
          Provider.of<BookingProvider>(context, listen: false);
      await bookingProvider.getAllBookings();
    } catch (e) {
      if (!mounted) return;
      CustomSnackbar.show(
        context,
        message: "Failed to load bookings. Please try again.",
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _deleteBooking(Booking booking) async {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    // Show confirmation dialog
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: Text(
            'Delete Booking',
            style: AppTextStyles.subtitle.copyWith(
              fontSize: 18.w,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this booking?',
            style: AppTextStyles.muted,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.mutedWhite),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await bookingProvider.cancelBooking(booking.id);
                  await _loadBookings();
                  if (mounted) Navigator.of(context).pop(true);
                } catch (e) {
                  if (mounted) {
                    CustomSnackbar.show(
                      context,
                      message: "Failed to delete booking. Please try again.",
                      type: SnackbarType.error,
                    );
                    Navigator.of(context).pop(false);
                  }
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        return ModalProgressHUD(
          inAsyncCall: bookingProvider.isLoading,
          blur: 5,
          progressIndicator: const CustomLoader(),
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.gradientBgStart, AppColors.gradientBgEnd],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.white,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              SizedBox(width: 8.w),
                              Text('My Bookings',
                                  style: AppTextStyles.headline),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Manage your court reservations',
                            style: AppTextStyles.muted,
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Expanded(
                      child: _buildBookingsContent(bookingProvider),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookingsContent(BookingProvider bookingProvider) {
    if (bookingProvider.isLoading) {
      return const Center(child: CustomLoader());
    }

    if (bookingProvider.errorMessage.isNotEmpty) {
      return _buildErrorState(bookingProvider);
    }

    if (bookingProvider.userBookings.isEmpty && !bookingProvider.isLoading) {
      return EmptyState(
        title: "No bookings yet",
        subtitle: "Your court reservations will appear here",
      );
    }

    return RefreshIndicator(
      onRefresh: _loadBookings,
      color: AppColors.accent,
      backgroundColor: AppColors.card,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: bookingProvider.userBookings.length,
        itemBuilder: (context, index) {
          final booking = bookingProvider.userBookings[index];
          return _buildBookingCard(booking);
        },
      ),
    );
  }

  Widget _buildBookingCard(Booking booking) {
    final DateTime bookingDate = booking.date;
    final bool isPast = bookingDate.isBefore(DateTime.now());
    final bool isToday = DateUtils.isSameDay(bookingDate, DateTime.now());

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: isPast
            ? Border.all(color: AppColors.mutedWhite.withOpacity(0.3))
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Facility Image
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.background,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.background,
                        child: Icon(
                          Icons.sports_tennis,
                          color: AppColors.mutedWhite,
                          size: 24.w,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.background,
                        child: Icon(
                          Icons.sports_tennis,
                          color: AppColors.mutedWhite,
                          size: 24.w,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Booking Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Facility Name
                      Text(
                        booking.facilityName,
                        style: AppTextStyles.subtitle.copyWith(
                          fontSize: 16.w,
                          fontWeight: FontWeight.w600,
                          color:
                              isPast ? AppColors.mutedWhite : AppColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),

                      // Court Label
                      Text(
                        booking.courtLabel,
                        style: AppTextStyles.muted.copyWith(
                          fontSize: 14.w,
                          color: isPast
                              ? AppColors.mutedWhite.withOpacity(0.7)
                              : AppColors.mutedWhite,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Date and Time
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16.w,
                            color: isPast
                                ? AppColors.mutedWhite.withOpacity(0.7)
                                : AppColors.accent,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            _formatDate(bookingDate),
                            style: TextStyle(
                              color: isPast
                                  ? AppColors.mutedWhite.withOpacity(0.7)
                                  : AppColors.white,
                              fontSize: 14.w,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),

                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16.w,
                            color: isPast
                                ? AppColors.mutedWhite.withOpacity(0.7)
                                : AppColors.accent,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            _formatTimeRange(
                                booking.startTime, booking.endTime),
                            style: TextStyle(
                              color: isPast
                                  ? AppColors.mutedWhite.withOpacity(0.7)
                                  : AppColors.white,
                              fontSize: 14.w,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status and Actions
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Status Badge
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color:
                            _getStatusColor(isPast, isToday).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getStatusColor(isPast, isToday),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _getStatusText(isPast, isToday),
                        style: TextStyle(
                          color: _getStatusColor(isPast, isToday),
                          fontSize: 10.w,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Delete Button
                    IconButton(
                      onPressed: () => _deleteBooking(booking),
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red.withOpacity(0.8),
                        size: 20.w,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 32.w,
                        minHeight: 32.w,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            ),

            // Price
            if (booking.price > 0) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.background.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${booking.price.toStringAsFixed(0)} TND',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
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
              'Failed to load bookings',
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
              onPressed: _loadBookings,
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final bookingDay = DateTime(date.year, date.month, date.day);

    if (bookingDay == today) {
      return 'Today';
    } else if (bookingDay == tomorrow) {
      return 'Tomorrow';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  String _formatTimeRange(TimeOfDay startTime, TimeOfDay endTime) {
    final start = _formatTimeOfDay(startTime);
    final end = _formatTimeOfDay(endTime);
    return '$start - $end';
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Color _getStatusColor(bool isPast, bool isToday) {
    if (isPast) return AppColors.mutedWhite;
    if (isToday) return AppColors.accent;
    return Colors.green;
  }

  String _getStatusText(bool isPast, bool isToday) {
    if (isPast) return 'COMPLETED';
    if (isToday) return 'TODAY';
    return 'UPCOMING';
  }
}
