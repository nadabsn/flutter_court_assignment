import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_assignment_flutter/providers/timer_provider.dart';

import 'core/config/app_responsive_config.dart';
import 'core/config/app_router.dart';
import 'core/config/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUiConfig().initialize(context);
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TimerProvider())],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
      ),
    );
  }
}
