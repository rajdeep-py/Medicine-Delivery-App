import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/main_wrapper.dart';
import '../screens/lab_test/lab_test_category_screen.dart';
import '../screens/lab_test/lab_test_list_screen.dart';
import '../screens/lab_test/lab_test_details_screen.dart';
import '../screens/lab_test/book_lab_test_screen.dart';
import '../screens/patho_lab/patho_lab_screen.dart';
import '../screens/patho_lab/patho_lab_detail_screen.dart';
import '../screens/medicine/medicine_category_screen.dart';
import '../screens/medicine/medicine_list_screen.dart';
import '../screens/medicine/medicine_detail_screen.dart';
import '../models/lab_test.dart';
import '../models/patho_lab.dart';
import '../models/medicine.dart';
import '../screens/profile/profile_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String medicine = '/medicine';
  static const String medicineList = '/medicine/list';
  static const String medicineDetails = '/medicine/details';
  static const String labTests = '/lab-tests';
  static const String labTestsList = '/lab-tests/list';
  static const String labTestsDetails = '/lab-tests/list/details';
  static const String bookLabTest = '/lab-tests/list/book';
  static const String pathoLabs = '/patho-labs';
  static const String pathoLabsDetails = '/patho-labs/details';
  static const String profile = '/profile';

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
      GoRoute(
        path: profile,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ProfileScreen(),
      ),

      GoRoute(
        path: labTestsDetails,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final test = state.extra as LabTest;
          return LabTestDetailsScreen(test: test);
        },
      ),
      GoRoute(
        path: bookLabTest,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final test = state.extra as LabTest;
          return BookLabTestScreen(test: test);
        },
      ),

      GoRoute(
        path: medicineList,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final category = state.extra as MedicineCategory;
          return MedicineListScreen(category: category);
        },
      ),

      GoRoute(
        path: medicineDetails,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final medicine = state.extra as Medicine;
          return MedicineDetailScreen(medicine: medicine);
        },
      ),

      GoRoute(
        path: pathoLabsDetails,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final lab = state.extra as PathoLab;
          return PathoLabDetailScreen(lab: lab);
        },
      ),

      // Main App Routes (Persistent Nav Bar)
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          int index = 0;
          if (state.uri.path.startsWith(medicine)) index = 1;
          if (state.uri.path.startsWith(labTests)) index = 2;
          if (state.uri.path.startsWith(pathoLabs)) index = 3;
          return MainWrapper(currentIndex: index, child: child);
        },
        routes: [
          GoRoute(
            path: home,
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Home Screen'))),
          ),
          GoRoute(
            path: medicine,
            builder: (context, state) => const MedicineCategoryScreen(),
          ),
          GoRoute(
            path: labTests,
            builder: (context, state) => const LabTestCategoryScreen(),
            routes: [
              GoRoute(
                path: 'list',
                builder: (context, state) {
                  final category = state.extra as LabTestCategory;
                  return LabTestListScreen(category: category);
                },
              ),
            ],
          ),
          GoRoute(
            path: pathoLabs,
            builder: (context, state) => const PathoLabScreen(),
          ),
        ],
      ),
    ],
  );
}
