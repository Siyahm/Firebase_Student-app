import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/screen/signUp/services/user_database_manage.dart';
import 'package:firebase_student_app/screen/signUp/view/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../view/sign_up_screen.dart';
import '../services/firebase_auth_methods.dart';

class SignUpScreenProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserDatabaseManage userDatabaseManage = UserDatabaseManage();

  void popFunction(context) {
    Navigator.pop(context);
  }

  Future<void> signUp(context) async {
    await FirebaseAuthMethods()
        .signUp(context, emailController.text, passwordController.text, auth)
        .then(
          (value) => userDatabaseManage
              .postUserDataToFirestore(
                context,
                nameController.text,
                emailController.text,
                passwordController.text,
                auth,
              )
              .then(
                (value) => clearControllers(),
              )
              .then(
                (value) => signOut(context),
              ),
        );
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void signUpTextButtonOnPressed(context) {
    clearControllers();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ScreenSignUp(),
      ),
    );
  }

  Future<void> signIn(context) async {
    await FirebaseAuthMethods()
        .signIn(context, emailController.text, passwordController.text, auth);
  }

  // void afterSignIn(context) {
  //   nameController.clear();
  //   emailController.clear();
  //   passwordController.clear();

  // }

  Future<void> signOut(context) async {
    await FirebaseAuthMethods().signOUt(context, auth);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInPage(),
      ),
    );
  }
}
