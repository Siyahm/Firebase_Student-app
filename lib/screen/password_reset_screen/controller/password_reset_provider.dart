import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/screen/signUp/view/sign_in_screen.dart';
import 'package:flutter/material.dart';

class PasswordResetProvider with ChangeNotifier {
  TextEditingController passwordResetController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    } else if (!value.contains("@")) {
      return 'Please enter valid email';
    }
  }

  void sendEmailLink() async {
    await auth.sendPasswordResetEmail(email: passwordResetController.text);
  }

  void afterClickSubmitButton(BuildContext context) {
    passwordResetController.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctxt) => SignInPage(),
      ),
    );
  }
}
