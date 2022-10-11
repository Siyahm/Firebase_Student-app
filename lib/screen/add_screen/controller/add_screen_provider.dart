import 'package:flutter/cupertino.dart';

enum ScreenAction {
  add,
  edit,
}

class AddScreenProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController domainController = TextEditingController();

  void popFunction(context) {
    Navigator.pop(context);
  }
}
