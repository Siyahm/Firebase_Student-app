import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/screen/home/view/home_screen.dart';
import 'package:firebase_student_app/screen/password_reset_screen/view/password_reset.dart';
import 'package:firebase_student_app/screen/signUp/services/user_database_manage.dart';
import 'package:firebase_student_app/screen/signUp/view/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../view/sign_up_screen.dart';
import '../services/firebase_auth_methods.dart';

class SignUpScreenProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserDatabaseManage userDatabaseManage = UserDatabaseManage();
  final signUpFormKey = GlobalKey<FormState>();

  void popFunction(context) {
    Navigator.pop(context);
  }

  Future<void> signUp(context) async {
    await FirebaseAuthMethods()
        .signUp(context, emailController.text, passwordController.text, auth)
        .then((value) => userDatabaseManage
                .postUserDataToFirestore(
              context,
              nameController.text,
              emailController.text,
              passwordController.text,
              auth,
            )
                .then(
              (value) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                    (route) => false);
                clearControllers();
              },
            ));
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

  void signUpButtonOnPressed(BuildContext context) async {
    if (signUpFormKey.currentState!.validate()) {
      await signUp(context);
    }
  }

  Future<void> signIn(context) async {
    await FirebaseAuthMethods()
        .signIn(context, emailController.text, passwordController.text, auth);
    clearControllers();
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
        builder: (context) => SignInPage(),
      ),
    );
  }

  nameClassDomainValidation(String? value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    }
  }

  emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    } else if (!value.contains("@")) {
      return 'Please enter valid email';
    }
  }

  passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
  }

  void onClickForgottButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordResetScreen(),
      ),
    );
  }
}
