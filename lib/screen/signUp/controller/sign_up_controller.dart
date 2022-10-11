import 'package:flutter/cupertino.dart';

class SignUpScreenProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void popFunction(context) {
    Navigator.pop(context);
  }
}
