import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_strings.dart';

import '../../core/utils/app_text_styles.dart';
import '../../providers/timer_provider.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';
import '../../widgets/gradient_scaffold.dart';
import 'widgets/timer_card.dart';

class TimerListScreen extends StatefulWidget {
  const TimerListScreen({super.key});

  @override
  TimerListScreenState createState() => TimerListScreenState();
}

class TimerListScreenState extends State<TimerListScreen>
    with TickerProviderStateMixin {
  int selectedTabIndex = 1; // Odoo tab selected by default
  int bottomNavIndex = 0; // Time sheets tab selected

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: selectedTabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: Consumer<TimerProvider>(
          builder: (context, timerProvider, child) {
            // Get the latest timer data from the provider
            return Column(
              children: [
                // Header with title and action buttons
                Padding(
                  padding: EdgeInsets.all(20.0.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppStrings.timeSheetsTitle,
                          style: AppTextStyles.headline,
                        ),
                      ),
                      // Action buttons
                      Container(
                        margin: EdgeInsets.only(right: 12.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.import_export,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            context.push('/create');
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
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
                    tabs: const [
                      Tab(text: 'Favorites'),
                      Tab(text: 'Odoo'),
                      Tab(text: 'Local'),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                // Timer count
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'You have ${timerProvider.timers.length} Timers',
                      style: AppTextStyles.muted,
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Timer List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: timerProvider.timers.length,
                    itemBuilder: (context, index) {
                      return TimerCard(timer: timerProvider.timers[index]);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: bottomNavIndex,
        onTap: (index) {
          setState(() {
            bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
