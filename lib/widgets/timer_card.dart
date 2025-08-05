import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';
import 'package:test_assignment_flutter/providers/timer_provider.dart';

import '../core/helpers/date_helper.dart';
import '../models/timer_model.dart';

class TimerCard extends StatefulWidget {
  final TimerModel timer;

  const TimerCard({super.key, required this.timer});

  @override
  State<TimerCard> createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, timerProvider, child) {
        // Get the latest timer data from the provider
        return GestureDetector(
          onTap: () {
            context.push('/task/${widget.timer.id}');
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row with star icon
                Row(
                  children: [
                    Icon(
                      widget.timer.isFavorite ? Icons.star : Icons.star_border,
                      color:
                          widget.timer.isFavorite
                              ? Colors.amber
                              : Colors.white.withOpacity(0.6),
                      size: 20,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        widget.timer.description,
                        style: AppTextStyles.subtitle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // Status indicator
                  ],
                ),

                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.folder_outlined,
                                color: Colors.white.withOpacity(0.6),
                                size: 16,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  widget.timer.project,
                                  style: AppTextStyles.timerProjectText,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8.w),

                          // Task info
                          Row(
                            children: [
                              Icon(
                                Icons.task_outlined,
                                color: Colors.white.withOpacity(0.6),
                                size: 16,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  widget.timer.task,
                                  style: AppTextStyles.timerProjectText,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.w),

                          // Start time and timer
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.white.withOpacity(0.6),
                                size: 16,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  widget.timer.startTime != null
                                      ? formatDateTime(widget.timer.startTime!)
                                      : ' Not started',
                                  style: AppTextStyles.timerProjectText,
                                ),
                              ),

                              // Timer display
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            widget.timer.status == TimerStatus.running
                                ? Colors.white
                                : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            formatDurationHHMM(widget.timer.elapsed),
                            style: AppTextStyles.buttonLabel.copyWith(
                              color: _getTextColor(widget.timer.status),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          InkWell(
                            onTap:
                                () => _handleTimerAction(
                                  timerProvider,
                                  widget.timer,
                                ),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                _getTimerIcon(widget.timer.status),
                                size: 20,
                                color: _getTextColor(widget.timer.status),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Project info
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleTimerAction(TimerProvider timerProvider, TimerModel timer) {
    switch (timer.status) {
      case TimerStatus.running:
        timerProvider.pauseTimer(timer.id);
        break;
      case TimerStatus.paused:
        timerProvider.startTimer(timer.id);
        break;
      case TimerStatus.stopped:
        timerProvider.startTimer(timer.id);
        break;
    }
  }

  IconData _getTimerIcon(TimerStatus status) {
    switch (status) {
      case TimerStatus.running:
        return Icons.pause;
      case TimerStatus.paused:
        return Icons.play_arrow;
      case TimerStatus.stopped:
        return Icons.play_arrow;
    }
  }

  Color _getTextColor(TimerStatus status) {
    if (status == TimerStatus.running) {
      return Colors.black;
    } else {
      return Colors.white.withOpacity(0.8);
    }
  }
}
