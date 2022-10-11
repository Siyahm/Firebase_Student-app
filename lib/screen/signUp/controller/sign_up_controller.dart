import 'package:firebase_student_app/screen/signUp/controller/firebase_auth_methods.dart';
import 'package:flutter/cupertino.dart';

class SignUpScreenProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void popFunction(context) {
    Navigator.pop(context);
  }

  Future<void> signUp(context) async {
    await FirebaseAuthMethods()
        .signUp(context, emailController.text, passwordController.text)
        .then(
          (value) => afterSignUp(context),
        );
  }

  void afterSignUp(context) {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    Navigator.pop(context);
  }
}
