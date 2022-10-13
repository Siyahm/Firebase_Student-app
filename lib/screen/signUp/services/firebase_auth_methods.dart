import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';

class FirebaseAuthMethods {
  //emil sign up
  Future<void> signUp(
      context, String email, String password, FirebaseAuth auth) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      showSnackBarWidget(context, e.message!, Colors.red);
    }
  }

//sign in
  Future<void> signIn(
      context, String email, String password, FirebaseAuth auth) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const HomeScreen(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      showSnackBarWidget(context, e.message!, Colors.red);
    } catch (e) {
      log(e.toString());
    }
  }

// sign out
  Future<void> signOUt(context, FirebaseAuth auth) async {
    try {
      await auth.signOut();
    } on FirebaseException catch (e) {
      showSnackBarWidget(context, e.message!, Colors.red);
    }
  }
}
