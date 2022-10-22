import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void confirmationPopUp(BuildContext context, String text, VoidCallback function,
    [int? index]) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Provider.of<HomeScreenProvider>(context, listen: false)
                      .visibilityListFalse();
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  function();
                  Provider.of<HomeScreenProvider>(context, listen: false)
                      .visibilityListFalse();
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
            ],
          ));
}
