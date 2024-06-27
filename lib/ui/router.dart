import 'package:flutter/material.dart';
import 'package:nutrisee/ui/auth/screen/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/ui/auth/screen/paginated_signup_screen.dart';
import 'package:nutrisee/ui/auth/screen/signup_screen.dart';
import 'package:nutrisee/ui/count_calories/screen/calories_screen.dart';
import 'package:nutrisee/ui/count_calories/screen/count_calories_screen.dart';
import 'package:nutrisee/ui/count_calories/screen/result_calories_screen.dart';
import 'package:nutrisee/ui/diabetes_risk/screen/diabetes_result_screen.dart';
import 'package:nutrisee/ui/diabetes_risk/screen/diabetes_risk_screen.dart';
import 'package:nutrisee/ui/diabetes_risk/screen/paginated_diabetes_test.dart';
import 'package:nutrisee/ui/home/screen/home_screen.dart';
import 'package:nutrisee/ui/meds_reminder/screen/meds_reminder_screen.dart';
import 'package:nutrisee/ui/menu_screen.dart';
import 'package:nutrisee/ui/profile/screen/profile_screen.dart';
import 'package:nutrisee/ui/scan_bmi/screen/count_bmi_screen.dart';
import 'package:nutrisee/ui/scan_bmi/screen/result_bmi_screen.dart';
import 'package:nutrisee/ui/scan_bmi/screen/scan_bmi_screen.dart';
import 'package:nutrisee/ui/scan_product/screen/scan_product_screen.dart';
import 'splash/screen/splash_screen.dart';

var router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/menu',
    builder: (context, state) => const MenuScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) => const PaginatedSignupScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) => const ProfileScreen(),
  ),
  GoRoute(
    path: '/diabetes-risk',
    builder: (context, state) => const DiabetesRiskScreen(),
  ),
  GoRoute(
    path: '/diabetes-risk-steps',
    builder: (context, state) => const PaginatedDiabetesTest(),
  ),
  GoRoute(
      path: '/diabetes-risk-result',
      builder: (context, state) {
        Map<String, dynamic> diabetesResult =
            state.extra as Map<String, dynamic>;
        return DiabetesResultScreen(diabetesResult: diabetesResult);
      }),
  GoRoute(
    path: '/scan-product',
    builder: (context, state) => const ScanProductScreen(),
  ),
  GoRoute(
    path: "/calories",
    builder: (context, state) => const CaloriesScreen(),
  ),
  GoRoute(
    path: "/count-calories",
    builder: (context, state) => const CountCaloriesScreen(),
  ),
  GoRoute(
    path: "/result-calories",
    builder: (context, state) {
      Map<String, double> data = state.extra as Map<String, double>;
      return ResultCaloriesScreen(
        dataCalories: data,
      );
    },
  ),
  GoRoute(
    path: "/bmi",
    builder: (context, state) => const ScanBmiScreen(),
  ),
  GoRoute(
    path: "/count-bmi",
    builder: (context, state) => CountBmiScreen(),
  ),
  GoRoute(
    path: "/result-bmi",
    builder: (context, state) {
      BMI data = state.extra as BMI;
      return ResultBmiScreen(
        bmiData: data,
      );
    },
  ),
  GoRoute(
    path: "/meds",
    builder: (context, state) => MedsReminderScreen(),
  ),
]);

Widget get errorPage => const Center(
      child: SizedBox(
        width: 200,
        child: Text('Error, maybe you forgot to include required obj'),
      ),
    );
