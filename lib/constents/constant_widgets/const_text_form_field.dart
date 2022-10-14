import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConstTextFormField extends StatelessWidget {
  ConstTextFormField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.validation,
  }) : super(key: key);

  final String? hint;
  final TextEditingController controller;
  final String? Function(String?)? validation;
  // final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
