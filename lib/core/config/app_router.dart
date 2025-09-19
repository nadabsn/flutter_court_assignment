import 'package:go_router/go_router.dart';
import 'package:test_assignment_flutter/features/bookings/screen/my_booking_screen.dart';
import 'package:test_assignment_flutter/features/facility/models/facility.dart';

import '../../features/facility/screen/facility_details.dart';
import '../../features/home/screen/home_screen.dart';

/**
 * AppRouter
 * This class defines the routing for the application using GoRouter.
 */

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Define the main route for the app
      GoRoute(path: '/', builder: (context, state) => FacilitiesListScreen()),
      // Define the routes for creating a timer and viewing a specific timer
      GoRoute(
        path: '/bookings',
        builder: (context, state) => MyBookingsScreen(),
      ),
      GoRoute(
        path: '/facility',
        builder: (context, state) {
          final facility = state.extra as Facility;
          return FacilityDetailsScreen(facility: facility);
        },
      ),
    ],
  );
}
