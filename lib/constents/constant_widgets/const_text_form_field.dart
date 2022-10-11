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
      decoration: const InputDecoration(
        hintText: 'Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
