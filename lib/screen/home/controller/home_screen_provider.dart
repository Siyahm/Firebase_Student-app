// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:firebase_student_app/screen/add_screen/services/student_database_manage.dart';
import 'package:firebase_student_app/screen/add_screen/view/add_screen.dart';
import 'package:firebase_student_app/screen/signUp/model/user_model.dart';
import 'package:firebase_student_app/screen/signUp/services/user_database_manage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreenProvider with ChangeNotifier {
  HomeScreenProvider() {
    getStudentList();
    setPic();
  }

  bool isLoading = false;

  UserDatabaseManage userDatabaseManage = UserDatabaseManage();
  FirebaseAuth auth = FirebaseAuth.instance;
  File? userImageFile;
  String? downloadUrl;
  List<StudentModel> studentList = [];
  late List visibilityList;

  StudentModel? model;

  // void getVisibleList() {
  //   visibilityList = List.generate(studentList.length, (index) => false);
  //   notifyListeners();
  // }

  //getting data from firestore to list
  void getStudentList() async {
    isLoading = true;
    notifyListeners();
    studentList = await StudentDatabaseManage().getStudentData(auth);
    visibilityList = List.generate(studentList.length, (index) => false);
    isLoading = false;
    notifyListeners();
  }

  void visibilityListFalse() {
    visibilityList = List.generate(studentList.length, (index) => false);
    notifyListeners();
  }

  void visibilityListTrue() {
    visibilityList = List.generate(studentList.length, (index) => true);
    notifyListeners();
  }

  void onLongPressedTile(int index) {
    visibilityList[index] = true;
    notifyListeners();
  }

  void onCancelLongPressedTile(int index) {
    visibilityList[index] = false;
    notifyListeners();
  }

  void onTapAddButtonfunction(
      context, ScreenAction screenAction, StudentModel? model) {
    AddScreenProvider().studentImage = null;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddScreen(
          screenAction: screenAction,
          model: model,
        ),
      ),
    );

    // StudentDatabaseManage().getStudentData(
    //   auth,
    // );
  }

  UserModel? userModel;
  void getUser(context) async {
    isLoading = true;
    notifyListeners();
    userModel = await userDatabaseManage.getUserData(context, auth);
    isLoading = false;
    notifyListeners();
  }

  getImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      userImageFile = File(image.path);
      await uploadPic(context, userImageFile!);
    }

    notifyListeners();
  }

  Future uploadPic(BuildContext context, File img) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("Users")
        .child(auth.currentUser!.uid)
        .child("userDp");
    TaskSnapshot taskSnapshot = await ref.putFile(img);
    if (taskSnapshot.state == TaskState.running) {
      showSnackBarWidget(context, "Uploading", Colors.green);
      log("uploading");
    }
    setPic();
    log(downloadUrl.toString());
  }

  void setPic() async {
    downloadUrl = await getPic();
    notifyListeners();
  }

  Future<String?> getPic() async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("Users")
          .child(auth.currentUser!.uid)
          .child("userDp");

      String downloadUrl = await ref.getDownloadURL();
      log(downloadUrl.toString());
      return downloadUrl;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
