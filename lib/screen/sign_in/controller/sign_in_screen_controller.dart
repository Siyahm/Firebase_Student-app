import 'package:firebase_student_app/screen/signUp/view/screen_sign_up.dart';
import 'package:flutter/material.dart';

class SignInScreenProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void signUpButtonOnPressed(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ScreenSignUp(),
      ),
    );
  }
}
