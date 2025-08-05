import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

/*import '../screens/create_timer_screen.dart';
import '../screens/timer_list_screen.dart';
import '../screens/task_details_screen/task_details_screen.dart';*/

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
      //  builder: (context, state) => const TimerListScreen(),
      ),
      GoRoute(
        path: '/create',
      //  builder: (context, state) => const CreateTimerScreen(),
      ),
      GoRoute(
        path: '/task/:id',
      /*  builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TaskDetailsScreen(taskId: id);
        },*/
      ),
    ],
  );
}
