import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_strings.dart';
import 'package:test_assignment_flutter/models/timer_model.dart';
import 'package:test_assignment_flutter/providers/timer_provider.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/gradient_scaffold.dart';

class CreateTimerScreen extends StatefulWidget {
  @override
  _CreateTimerScreenState createState() => _CreateTimerScreenState();
}

class _CreateTimerScreenState extends State<CreateTimerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  String? selectedProject;
  String? selectedTask;
  bool isFavorite = false;

  final List<String> projects = [
    'S0056 - Booqio V2',
    'S0057 - Mobile App',
    'S0058 - Web Platform',
    'S0059 - API Development',
  ];

  final List<String> tasks = [
    'iOS app deployment',
    'Android development',
    'UI/UX Design',
    'Backend API',
    'Database optimization',
    'Testing & QA',
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _createTimer() {
    if (_formKey.currentState!.validate()) {
      final newTimer = TimerModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        description: _descriptionController.text,
        project: selectedProject ?? '',
        task: selectedTask ?? '',
        isFavorite: isFavorite,
        startTime: DateTime.now(),
      );

      TimerProvider timerProvider = Provider.of<TimerProvider>(
        context,
        listen: false,
      );
      timerProvider.addTimer(
        description: newTimer.description,
        project: newTimer.project,
        task: newTimer.task,
        isFavorite: newTimer.isFavorite,
      );
      Navigator.of(context).pop(newTimer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          // Header
                          Padding(
                            padding: EdgeInsets.all(20.0.w),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.white,
                                    size: 20.w,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    AppStrings.createTimer,
                                    style: AppTextStyles.headline?.copyWith(
                                      fontSize: 24.w,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(width: 48.w),
                                // Balance the back button
                              ],
                            ),
                          ),

                          // Form
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(height: 20.h),

                                  // Project Dropdown with validation
                                  FormField<String>(
                                    validator: (_) {
                                      if (selectedProject == null) {
                                        return 'Project is required';
                                      }
                                      return null;
                                    },
                                    builder:
                                        (state) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomDropdownButton(
                                              hint: 'Project',
                                              items: projects,
                                              selectedValue: selectedProject,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selectedProject = newValue;
                                                  state.didChange(newValue);
                                                });
                                              },
                                            ),
                                            if (state.hasError)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 6.h,
                                                  left: 12.w,
                                                ),
                                                child: Text(
                                                  state.errorText!,
                                                  style:
                                                      AppTextStyles.errorText,
                                                ),
                                              ),
                                          ],
                                        ),
                                  ),

                                  SizedBox(height: 16.h),

                                  // Task Dropdown with validation
                                  FormField<String>(
                                    validator: (_) {
                                      if (selectedTask == null) {
                                        return 'Task is required';
                                      }
                                      return null;
                                    },
                                    builder:
                                        (state) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomDropdownButton(
                                              hint: 'Task',
                                              items: tasks,
                                              selectedValue: selectedTask,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selectedTask = newValue;
                                                  state.didChange(newValue);
                                                });
                                              },
                                            ),
                                            if (state.hasError)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 6.h,
                                                  left: 12.w,
                                                ),
                                                child: Text(
                                                  state.errorText!,
                                                  style:
                                                      AppTextStyles.errorText,
                                                ),
                                              ),
                                          ],
                                        ),
                                  ),

                                  SizedBox(height: 16.h),

                                  // Description Field with validation
                                  CustomTextField(
                                    hint: 'Description',
                                    controller: _descriptionController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Description is required';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 24.h),

                                  // Make Favorite Toggle
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.card.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      leading: Icon(
                                        isFavorite
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: AppColors.white,
                                      ),
                                      title: Text(
                                        'Make Favorite',
                                        style: AppTextStyles.subtitle,
                                      ),
                                      trailing: Switch(
                                        value: isFavorite,
                                        onChanged: (value) {
                                          setState(() {
                                            isFavorite = value;
                                          });
                                        },
                                        activeColor: AppColors.accent,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Create Timer Button - This will be pushed to bottom
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(20.0.w),
                        child: TransparentWhiteButton(
                          text: AppStrings.createTimer,
                          onPressed: _createTimer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
