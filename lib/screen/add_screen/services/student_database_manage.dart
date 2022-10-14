import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:flutter/material.dart';

class StudentDatabaseManage {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final studentId = DateTime.now().millisecondsSinceEpoch.toString();
  List<StudentModel> studentList = [];
  Future<void> createStudentCollection(
    String name,
    String std,
    String age,
    String domain,
    FirebaseAuth auth,
    BuildContext context,
  ) async {
    try {
      User user = auth.currentUser!;
      StudentModel studentModel = StudentModel(
        name: name,
        std: std,
        age: age,
        domain: domain,
        studentId: studentId,
      );

      await firebaseFirestore
          .collection('Users')
          .doc(user.uid)
          .collection('Students')
          .doc(studentId)
          .set(studentModel.studentDataToMap());
    } catch (e) {
      showSnackBarWidget(context, e.toString(), Colors.red);
    }
  }

  Future<List<StudentModel>> getStudentData(
    FirebaseAuth auth,
  ) async {
    User user = auth.currentUser!;
    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .collection("Students")
        .get()
        .then((value) {
      for (var student in value.docs) {
        studentList.add(
          StudentModel.studentDataformMap(
            student.data(),
          ),
        );
      }
    });
    log(studentList.toString());
    return studentList;
  }

  Future<void> updateStudentCollection(
    String name,
    String std,
    String age,
    String domain,
    FirebaseAuth auth,
    BuildContext context,
    String studentId,
  ) async {
    try {
      User user = auth.currentUser!;
      StudentModel studentModel = StudentModel(
        name: name,
        std: std,
        age: age,
        domain: domain,
        studentId: studentId,
      );

      await firebaseFirestore
          .collection('Users')
          .doc(user.uid)
          .collection('Students')
          .doc(studentId)
          .update(studentModel.studentDataToMap());
    } catch (e) {
      showSnackBarWidget(context, e.toString(), Colors.red);
    }
  }

  Future<void> deleteStudent(FirebaseAuth auth, String id) async {
    User user = auth.currentUser!;
    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .collection("Students")
        .doc(id)
        .delete();
    // log(studentList[index].studentId!);
  }
}
