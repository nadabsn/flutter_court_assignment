// Method 1: Custom Scaffold with Gradient Background
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';


class GradientScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;

  const GradientScaffold({
    super.key,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.gradientBgStart, AppColors.gradientBgEnd],
          stops: [0.0, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // Make scaffold transparent
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        drawer: drawer,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
