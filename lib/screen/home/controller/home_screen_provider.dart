import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:firebase_student_app/screen/add_screen/services/student_database_manage.dart';
import 'package:firebase_student_app/screen/add_screen/view/add_screen.dart';
import 'package:firebase_student_app/screen/signUp/model/user_model.dart';
import 'package:firebase_student_app/screen/signUp/services/user_database_manage.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  final visibilityList = List.generate(10, (index) => false);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserDatabaseManage userDatabaseManage = UserDatabaseManage();
  FirebaseAuth auth = FirebaseAuth.instance;

  void onLongPressedTile(int index) {
    visibilityList[index] = true;
    notifyListeners();
  }

  void onCancelLongPressedTile(int index) {
    visibilityList[index] = false;
    notifyListeners();
  }

  void onTapfunction(context, ScreenAction screenAction, StudentModel? model) {
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
  Future<void> getUser(context) async {
    userModel = await userDatabaseManage.getUserData(context, auth);
    notifyListeners();
  }
}
