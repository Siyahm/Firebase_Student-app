import 'package:flutter/material.dart';

void showSnackBarWidget(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Color.fromARGB(255, 191, 13, 0),
      content: Text(text),
    ),
  );
}
