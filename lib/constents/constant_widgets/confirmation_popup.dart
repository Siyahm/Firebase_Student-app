import 'package:flutter/material.dart';

void confirmationPopUp(
    BuildContext context, String text, VoidCallback function) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  function();
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
            ],
          ));
}
