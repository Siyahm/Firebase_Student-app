import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:firebase_student_app/screen/add_screen/services/student_database_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddScreenProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  List<StudentModel> studentList = [];
  final formKey = GlobalKey<FormState>();

  void popFunction(context) {
    Navigator.pop(context);
  }

  void clearControllers() {
    nameController.clear();
    classController.clear();
    ageController.clear();
    domainController.clear();
  }

//fnction called onClick of save button to add student to firestore
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
              const Color.fromARGB(255, 0, 147, 5),
            ));
    getStudentList();
    notifyListeners();
  }

//getting data from firestore to list
  void getStudentList() async {
    studentList = await StudentDatabaseManage().getStudentData(auth);
    notifyListeners();
  }

//fucntion called in constructor to call in homepage
  AddScreenProvider() {
    getStudentList();
    notifyListeners();
  }
//fill data in edit screen
  void fillEditScreen(StudentModel? model, ScreenAction screenAction) {
    if (screenAction == ScreenAction.edit) {
      nameController.text = model!.name!;
      classController.text = model.std!;
      ageController.text = model.age!;
      domainController.text = model.domain!;
    }
    notifyListeners();
  }

  Future<void> updateStudentToFirestore(
      BuildContext context, String studentId) async {
    await StudentDatabaseManage()
        .updateStudentCollection(
          nameController.text,
          classController.text,
          ageController.text,
          domainController.text,
          auth,
          context,
          studentId,
        )
        .then((value) => clearControllers())
        .then((value) => showSnackBarWidget(
              context,
              'Student has been updated successfully',
              const Color.fromARGB(255, 0, 147, 5),
            ));
    getStudentList();
    notifyListeners();
  }

  void deleteStudent(String id) {
    StudentDatabaseManage().deleteStudent(auth, id);
    getStudentList();
    notifyListeners();
  }

  nameClassDomainValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    }
    return '';
  }

  ageValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    } else if (value.length > 2) {
      return 'Please enter a valid age';
    }
    return '';
  }
}
