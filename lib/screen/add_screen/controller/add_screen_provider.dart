// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:firebase_student_app/screen/add_screen/services/student_database_manage.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:firebase_student_app/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddScreenProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String passedImage = '';

  final formKey = GlobalKey<FormState>();
  File? studentImage;
  String? studentDpUrl;

  final id = DateTime.now().millisecondsSinceEpoch.toString();

  void popFunction(context) {
    Navigator.pop(context);
  }

  pickStudentImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      studentImage = File(image.path);
    }

    notifyListeners();
  }

  void clearControllers() {
    nameController.clear();
    classController.clear();
    ageController.clear();
    domainController.clear();
    notifyListeners();
  }

//fnction called onClick of save button to add student to firestore
  Future<void> addStudentToFirestore(BuildContext context) async {
    await StudentDatabaseManage()
        .createStudentCollection(
          nameController.text,
          classController.text,
          ageController.text,
          domainController.text,
          studentDpUrl!,
          auth,
          context,
          id,
        )
        .then((value) => showSnackBarWidget(
              context,
              'Student has been added successfully',
              const Color.fromARGB(255, 0, 147, 5),
            ));

    notifyListeners();
  }

//fill data in edit screen
  void fillEditScreen(StudentModel? model, ScreenAction screenAction) {
    if (screenAction == ScreenAction.edit) {
      nameController.text = model!.name!;
      classController.text = model.std!;
      ageController.text = model.age!;
      domainController.text = model.domain!;
      passedImage = model.image!;
    }
    notifyListeners();
  }

  Future<void> updateStudentToFirestore(
      BuildContext context, String studentId, String? studentDpUrl) async {
    await StudentDatabaseManage()
        .updateStudentCollection(
          nameController.text,
          classController.text,
          ageController.text,
          domainController.text,
          studentDpUrl,
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

    HomeScreenProvider().getStudentList();
    notifyListeners();
  }

  void deleteStudent(String id) {
    StudentDatabaseManage().deleteStudent(auth, id);
    HomeScreenProvider().getStudentList();
    notifyListeners();
  }

  // File? studentImageforUpdate;
  // setStudentImageForUpdate() {
  //   StudentModel? model;
  //   if (studentImage == null) {
  //     studentImageforUpdate = model.image;
  //   }
  // }

  void onClickSaveButton(ScreenAction screenAction, BuildContext context,
      StudentModel? model) async {
    if (formKey.currentState!.validate()) {
      if (screenAction == ScreenAction.add) {
        await uploadStudentPic(context, studentImage!);
        await addStudentToFirestore(context);
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        if (studentImage != null) {
          await updateStudentPic(context, studentImage!, model!.studentId!);
        }

        await updateStudentToFirestore(
                context, model!.studentId!, studentDpUrl ?? model.image)
            .then((value) => popFunction(context));
      }
    }
  }

  Future uploadStudentPic(BuildContext context, File img) async {
    // final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref()
        .child('Users')
        .child(auth.currentUser!.uid)
        .child('Students')
        .child(id)
        .child('Dp');
    TaskSnapshot taskSnapshot = await ref.putFile(img);
    if (taskSnapshot.state == TaskState.running) {
      showSnackBarWidget(context, 'Image Uploading...', Colors.green);
    }
    studentDpUrl = await getPicUrl(id);
  }

  // Future<String> getUpdatedPicUrl(String id) async {
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child('Users')
  //       .child(auth.currentUser!.uid)
  //       .child('Students')
  //       .child(id)
  //       .child('Dp');
  //   String studentDpUrl = await ref.getDownloadURL();
  //   log(studentDpUrl.toString());
  //   return studentDpUrl;
  // }

  Future updateStudentPic(
      BuildContext context, File img, String currentId) async {
    // final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref()
        .child('Users')
        .child(auth.currentUser!.uid)
        .child('Students')
        .child(currentId)
        .child('Dp');
    TaskSnapshot taskSnapshot = await ref.putFile(img);
    if (taskSnapshot.state == TaskState.running) {
      showSnackBarWidget(context, 'Image Uploading...', Colors.green);
    }
    studentDpUrl = await getPicUrl(currentId);
  }

  Future<String> getPicUrl(String id) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('Users')
        .child(auth.currentUser!.uid)
        .child('Students')
        .child(id)
        .child('Dp');
    String studentDpUrl = await ref.getDownloadURL();
    log(studentDpUrl.toString());
    return studentDpUrl;
  }

  ageValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    } else if (value.length > 2) {
      return 'Please enter a valid age';
    }
  }

  emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    } else if (!value.contains("@")) {
      return 'Please enter valid email';
    }
  }

  nameClassDomainValidation(String? value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    }
  }
}
