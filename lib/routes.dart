import 'package:chat_app/pages/Home/home_screen.dart';
import 'package:chat_app/pages/login/phoneNumber_login.dart';
import 'package:chat_app/pages/login/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String mainScreen = '/';
  static const String phoneAuthScreen = '/phone-auth-screen';

  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return FirebaseAuth.instance.currentUser == null
            ? MaterialPageRoute(builder: (context) => const WelcomeScreen())
            : MaterialPageRoute(builder: (context) => const HomeScreen());
      case phoneAuthScreen:
        return MaterialPageRoute(builder: (context) => PhoneAuthScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}
