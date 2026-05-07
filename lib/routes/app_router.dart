import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/main_wrapper.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String medicine = '/medicine';
  static const String labTests = '/lab-tests';
  static const String pathoLabs = '/patho-labs';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    navigatorKey: _rootNavigatorKey,
    routes: [
      // Auth Routes
      GoRoute(
        path: splash,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: login,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginScreen(),
      ),

      // Main App Routes (Persistent Nav Bar)
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          int index = 0;
          if (state.uri.path == medicine) index = 1;
          if (state.uri.path == labTests) index = 2;
          if (state.uri.path == pathoLabs) index = 3;
          return MainWrapper(currentIndex: index, child: child);
        },
        routes: [
          GoRoute(
            path: home,
            builder: (context, state) => const Scaffold(body: Center(child: Text('Home Screen'))),
          ),
          GoRoute(
            path: medicine,
            builder: (context, state) => const Scaffold(body: Center(child: Text('Medicine Screen'))),
          ),
          GoRoute(
            path: labTests,
            builder: (context, state) => const Scaffold(body: Center(child: Text('Lab Tests Screen'))),
          ),
          GoRoute(
            path: pathoLabs,
            builder: (context, state) => const Scaffold(body: Center(child: Text('Patho Labs Screen'))),
          ),
        ],
      ),
    ],
  );
}
