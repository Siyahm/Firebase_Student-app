import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/screen/home/view/home_screen.dart';
import 'package:firebase_student_app/screen/signUp/view/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenProvider with ChangeNotifier {
  void checkLogin(context) {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }
}
