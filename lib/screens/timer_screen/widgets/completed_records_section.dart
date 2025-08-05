import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

import 'completed_record_card.dart';

class CompletedRecordsSection extends StatelessWidget {
  const CompletedRecordsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Completed Records',
          style: AppTextStyles.headline?.copyWith(fontSize: 16.w),
        ),
        SizedBox(height: 16.h),

        // Completed Record 1
        CompletedRecordCard(
          dayName: 'Sunday',
          date: '16.06.2023',
          startTime: '10:00',
          duration: '08:00',
        ),

        // Completed Record 2
        CompletedRecordCard(
          dayName: 'Sunday',
          date: '16.06.2023',
          startTime: '10:00',
          duration: '08:00',
        ),
      ],
    );
  }
}
