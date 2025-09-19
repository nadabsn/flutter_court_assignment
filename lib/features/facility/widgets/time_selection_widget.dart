import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';

class TimeSelectionWidget extends StatelessWidget {
  final List<TimeOfDay> allTimeSlots;
  final List<TimeOfDay> availableTimeSlots;
  final TimeOfDay? selectedStartTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimeSelectionWidget({
    super.key,
    required this.allTimeSlots,
    required this.availableTimeSlots,
    required this.selectedStartTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Times',
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 18.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        if (allTimeSlots.isEmpty) ...[
          _buildEmptyState(),
        ] else
          ...[
            _buildTimeGrid(context),
          ],
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.schedule, size: 48.w, color: AppColors.mutedWhite),
            SizedBox(height: 8.h),
            Text(
              'No time slots available',
              style: AppTextStyles.muted,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 2.5,
      ),
      itemCount: allTimeSlots.length,
      // Changed from availableTimeSlots to allTimeSlots
      itemBuilder: (context, index) {
        final timeSlot = allTimeSlots[index];
        final isSelected = selectedStartTime == timeSlot;
        final isAvailable =
        availableTimeSlots.contains(timeSlot); // Check if slot is available

        return TimeSlotCard(
          timeSlot: timeSlot,
          isSelected: isSelected,
          isAvailable: isAvailable, // Pass availability status
          onTap: isAvailable
              ? () => onTimeSelected(timeSlot)
              : null, // Only allow tap if available
        );
      },
    );
  }
}

class TimeSlotCard extends StatelessWidget {
  final TimeOfDay timeSlot;
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback? onTap;

  const TimeSlotCard({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    required this.isAvailable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.w),
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(
            color: _getBorderColor(),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            timeSlot.format(context),
            style: AppTextStyles.buttonLabel.copyWith(
              color: _getTextColor(),
              fontSize: 14.w,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!isAvailable) {
      return AppColors.card.withOpacity(0.5); // Disabled appearance
    }
    return isSelected ? AppColors.accent : AppColors.card;
  }

  Color _getBorderColor() {
    if (!isAvailable) {
      return Colors.grey.withOpacity(0.3); // Subtle border for disabled
    }
    return isSelected ? AppColors.accent : Colors.transparent;
  }

  Color _getTextColor() {
    if (!isAvailable) {
      return Colors.grey; // Grey text for disabled
    }
    return isSelected ? AppColors.background : Colors.white;
  }
}
