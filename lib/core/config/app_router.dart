import 'package:go_router/go_router.dart';
import 'package:test_assignment_flutter/screens/timer_screen/timer_screen.dart';

import '../../screens/create_timer_screen/create_timer_screen.dart';
import '../../screens/timer_list_screen/timer_list_screen.dart';

/**
 * AppRouter
 * This class defines the routing for the application using GoRouter.
 * It includes routes for the main timer list screen,
 * creating a new timer,
 * and viewing a specific timer by ID.
 */

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Define the main route for the app
      GoRoute(path: '/', builder: (context, state) => TimerListScreen()),
      // Define the routes for creating a timer and viewing a specific timer
      GoRoute(
        path: '/create',
        builder: (context, state) => CreateTimerScreen(),
      ),
      GoRoute(
        path: '/task/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TimerScreen(timerId: id);
        },
      ),
    ],
  );
}
