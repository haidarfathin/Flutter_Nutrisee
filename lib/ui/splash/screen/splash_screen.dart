import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widget/im_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.go('/home');
    } else {
      // No user is signed in, navigate to the login screen
      Future.delayed(const Duration(seconds: 1), () => context.go('/login'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ImLogo(),
    );
  }
}
