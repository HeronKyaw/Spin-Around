import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:spin_around/modules/auth/views/auth_screen.dart';
import 'package:spin_around/modules/auth/views/verify_email_screen.dart';
import 'package:spin_around/modules/home/views/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String tag = '/';

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  // Check if the user is logged in
  void _checkUserStatus() async {
    // Wait for 2 seconds to simulate a splash screen delay
    await Future.delayed(Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;

    if (mounted) {
      if (user == null) {
        context.pushReplacementNamed(AuthScreen.tag);
      } else if (!user.emailVerified){
        context.pushReplacementNamed(VerifyEmailScreen.tag);
      } else {
        context.pushReplacementNamed(Home.tag);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Hero(
          tag: 'appLogo',
          child: Image.asset(
            'assets/icon/app-logo.png',
            height: 200,
          ),
        ),
      ),
    );
  }
}
