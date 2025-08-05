import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_extension_functions.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';
import 'package:test_assignment_flutter/models/timer_model.dart';

class CurrentTimerCard extends StatelessWidget {
  final TimerModel? timer;
  final VoidCallback onToggleTimer;
  final VoidCallback onStopTimer;

  const CurrentTimerCard({
    super.key,
    required this.timer,
    required this.onToggleTimer,
    required this.onStopTimer,
  });

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            timer?.startTime?.dayName ?? 'Monday',
            style: AppTextStyles.muted.copyWith(fontSize: 14.w),
          ),
          SizedBox(height: 4.h),
          Text(
            timer?.startTime?.formattedDate ?? '01.01.2023',
            style: AppTextStyles.headline?.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            timer?.startTime != null
                ? 'Start Time ${timer?.startTime?.hour.toString().padLeft(2, '0')}:${timer?.startTime?.minute.toString().padLeft(2, '0')}'
                : "Not started",
            style: AppTextStyles.muted.copyWith(fontSize: 14.w),
          ),
          SizedBox(height: 20.h),

          // Timer Display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_formatTime(timer?.elapsed.inHours ?? 0)}:${_formatTime((timer?.elapsed.inMinutes ?? 0) % 60)}:${_formatTime((timer?.elapsed.inSeconds ?? 0) % 60)}',
                style: AppTextStyles.timerElapsedTime,
              ),
              Row(
                children: [
                  // Stop Button
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: IconButton(
                      onPressed: onStopTimer,
                      icon: const Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Play/Pause Button
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: onToggleTimer,
                      icon: Icon(
                        timer?.status == TimerStatus.running
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
