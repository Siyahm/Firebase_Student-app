import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/screen/add_screen/services/student_database_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ScreenAction {
  add,
  edit,
}

class AddScreenProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void popFunction(context) {
    Navigator.pop(context);
  }

  void clearControllers() {
    nameController.clear();
    classController.clear();
    ageController.clear();
    domainController.clear();
  }

  Future<void> addStudentToFirestore(BuildContext context) async {
    await StudentDatabaseManage()
        .createStudentCollection(
          nameController.text,
          classController.text,
          ageController.text,
          domainController.text,
          auth,
          context,
        )
        .then((value) => clearControllers())
        .then((value) => showSnackBarWidget(
              context,
              'Student has been added successfully',
              Color.fromARGB(255, 0, 147, 5),
            ));
  }
}
