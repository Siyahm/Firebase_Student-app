import 'package:flutter/material.dart';

class ConstTextFormField extends StatelessWidget {
  const ConstTextFormField({
    Key? key,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  final String? hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
