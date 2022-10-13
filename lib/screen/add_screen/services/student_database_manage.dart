import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentDatabaseManage {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final studentId = DateTime.now().millisecondsSinceEpoch.toString();
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
}
