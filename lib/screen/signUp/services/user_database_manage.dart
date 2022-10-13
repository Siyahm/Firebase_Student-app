import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/screen/signUp/model/user_model.dart';
import 'package:flutter/material.dart';

class UserDatabaseManage {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> postUserDataToFirestore(context, String name, String email,
      String password, FirebaseAuth auth) async {
    try {
      User? user = auth.currentUser;
      UserModel userModel = UserModel(
        uid: user!.uid,
        name: name,
        email: email,
        password: password,
      );
      log(user.uid);

      await firebaseFirestore.collection('Users').doc(user.uid).set(
            userModel.toMap(),
          );
    } catch (e) {
      showSnackBarWidget(
        context,
        e.toString(),
        Colors.red,
      );
    }
  }

  Future<UserModel?> getUserData(context, FirebaseAuth auth) async {
    try {
      User? user = auth.currentUser;

      UserModel? getUserData;
      await firebaseFirestore
          .collection('Users')
          .doc(user!.uid)
          .get()
          .then((value) {
        getUserData = UserModel.fromMap(value.data()!);
      });
      return getUserData;
    } catch (e) {
      showSnackBarWidget(
        context,
        e.toString(),
        Colors.red,
      );
    }
    return null;
  }
}
