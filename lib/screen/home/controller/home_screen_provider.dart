import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/screen/add_screen/view/add_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  final visibilityList = List.generate(10, (index) => false);

  void onLongPressedTile(int index) {
    visibilityList[index] = true;
    notifyListeners();
  }

  void onCancelLongPressedTile(int index) {
    visibilityList[index] = false;
    notifyListeners();
  }

  void onTapfunction(context, ScreenAction screenAction) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddScreen(
          screenAction: screenAction,
        ),
      ),
    );
  }
}
