import 'package:flutter/material.dart';
import 'package:nutrisee/ui/auth/screen/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/ui/auth/screen/signup_screen.dart';
import 'package:nutrisee/ui/diabetes_risk/screen/diabetes_result_screen.dart';
import 'package:nutrisee/ui/diabetes_risk/screen/diabetes_risk_screen.dart';
import 'package:nutrisee/ui/diabetes_risk/screen/paginated_diabetes_test.dart';
import 'package:nutrisee/ui/home/screen/home_screen.dart';
import 'package:nutrisee/ui/menu_screen.dart';
import 'package:nutrisee/ui/profile/screen/profile_screen.dart';
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
    builder: (context, state) => const SignupScreen(),
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
    builder: (context, state) => const DiabetesResultScreen(),
  ),
  GoRoute(
    path: '/scan-product',
    builder: (context, state) => const ScanProductScreen(),
  ),
]);

Widget get errorPage => const Center(
      child: SizedBox(
        width: 200,
        child: Text('Error, maybe you forgot to include required obj'),
      ),
    );
