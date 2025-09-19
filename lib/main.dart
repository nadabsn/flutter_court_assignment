import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_assignment_flutter/features/bookings/service/booking_service.dart';

import 'core/config/app_responsive_config.dart';
import 'core/config/app_router.dart';
import 'core/config/app_theme.dart';
import 'core/services/storage_service.dart';
import 'features/bookings/providers/booking_provider.dart';
import 'features/facility/providers/facility_provider.dart';
import 'features/facility/service/facility_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      LocalStorageService().init;
      ResponsiveUiConfig().initialize(context);
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => FacilityProvider(FacilityService()),
          ),
          ChangeNotifierProvider(
            create: (context) => BookingProvider(BookingService()),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: appTheme,
        ),
      );
    });
  }
}
