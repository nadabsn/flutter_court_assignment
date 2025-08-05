import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/models/timer_model.dart';

import 'completed_records_section.dart';
import 'current_timer_card.dart';
import 'description_section.dart';

class TimeSheetsTab extends StatelessWidget {
  final TimerModel? timer;
  final VoidCallback onToggleTimer;
  final VoidCallback onStopTimer;

  const TimeSheetsTab({
    super.key,
    required this.timer,
    required this.onToggleTimer,
    required this.onStopTimer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Timer Card
          CurrentTimerCard(
            timer: timer,
            onToggleTimer: onToggleTimer,
            onStopTimer: onStopTimer,
          ),

          SizedBox(height: 24.h),

          // Description Section
          DescriptionSection(
            description:
                'Sync with Client, communicate, work on the new design with designer, new tasks preparati...',
            onEdit: () {},
          ),

          SizedBox(height: 32.h),

          // Completed Records
          CompletedRecordsSection(),

          SizedBox(height: 24.h),

          // Second Description Section
          DescriptionSection(
            description:
                'As a user, I would like to be able to buy a subscription, this would allow me to get a discount on the products and on the second stage of diagnosis',
            onEdit: () {},
            showReadMore: false,
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
