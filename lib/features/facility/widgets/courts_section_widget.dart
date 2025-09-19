import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_colors.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

import '../../bookings/models/court.dart';

class CourtsSectionWidget extends StatelessWidget {
  final List<Court> courts;
  final Court? selectedCourt;
  final Function(Court) onCourtSelected;

  const CourtsSectionWidget({
    super.key,
    required this.courts,
    required this.selectedCourt,
    required this.onCourtSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Courts',
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 20.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        ...courts.map((court) => CourtCard(
              court: court,
              isSelected: selectedCourt?.id == court.id,
              onTap: () => onCourtSelected(court),
            )),
      ],
    );
  }
}

class CourtCard extends StatelessWidget {
  final Court court;
  final bool isSelected;
  final VoidCallback onTap;

  const CourtCard({
    super.key,
    required this.court,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.accent.withOpacity(0.1) : AppColors.card,
        borderRadius: BorderRadius.circular(12.w),
        border:
            isSelected ? Border.all(color: AppColors.accent, width: 2) : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.w),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Sport Icon
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Icon(
                  _getSportIcon(court.sport),
                  size: 24.w,
                  color: AppColors.accent,
                ),
              ),
              SizedBox(width: 16.w),

              // Court Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      court.label,
                      style: AppTextStyles.subtitle.copyWith(
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.accent : Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${court.sport.toUpperCase()} • ${court.slotMinutes}min slots',
                      style: AppTextStyles.muted.copyWith(fontSize: 12.w),
                    ),
                    Text(
                      'Open: ${court.dailyOpen} - ${court.dailyClose}',
                      style: AppTextStyles.muted.copyWith(fontSize: 12.w),
                    ),
                  ],
                ),
              ),

              // Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${court.price.toInt()} DT',
                    style: AppTextStyles.subtitle.copyWith(
                      fontSize: 18.w,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                  Text(
                    'per ${court.slotMinutes}min',
                    style: AppTextStyles.muted.copyWith(fontSize: 10.w),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'tennis':
        return Icons.sports_tennis;
      case 'basketball':
        return Icons.sports_basketball;
      case 'padel':
        return Icons.sports_tennis;
      default:
        return Icons.sports;
    }
  }
}
