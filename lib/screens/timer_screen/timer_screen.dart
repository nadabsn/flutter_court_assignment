import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';
import 'package:test_assignment_flutter/models/timer_model.dart';
import 'package:test_assignment_flutter/providers/timer_provider.dart';
import 'package:test_assignment_flutter/screens/timer_screen/widgets/timer_sheets_tab.dart';
import 'package:test_assignment_flutter/widgets/gradient_scaffold.dart';

import '../../core/utils/app_strings.dart';
import 'widgets/details_tab.dart';
import 'widgets/timer_header.dart';

class TimerScreen extends StatefulWidget {
  final String timerId;

  const TimerScreen({super.key, required this.timerId});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  late TabController _tabController;
  TimerModel? timer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _toggleTimer() {
    TimerProvider timerProvider = Provider.of<TimerProvider>(
      context,
      listen: false,
    );
    timerProvider.toggleTimer(widget.timerId);
  }

  void _stopTimer() {
    TimerProvider timerProvider = Provider.of<TimerProvider>(
      context,
      listen: false,
    );
    timerProvider.stopTimer(widget.timerId);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: Consumer<TimerProvider>(
          builder: (context, timerProvider, child) {
            timer = timerProvider.getTimerById(widget.timerId);
            return Column(
              children: [
                // Header
                TimerHeader(
                  timer: timer,
                  onBack: () => Navigator.pop(context),
                  onEdit: () {},
                ),

                // Tab Bar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withOpacity(0.6),
                    labelStyle: AppTextStyles.subtitle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: [
                      Tab(text: AppStrings.timeSheetsTitle),
                      Tab(text: AppStrings.detailsTitle),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TimeSheetsTab(
                        timer: timer,
                        onToggleTimer: _toggleTimer,
                        onStopTimer: _stopTimer,
                      ),
                      DetailsTab(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
