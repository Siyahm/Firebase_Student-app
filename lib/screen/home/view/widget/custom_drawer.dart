import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/signUp/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpScrnProvider =
        Provider.of<SignUpScreenProvider>(context, listen: false);
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                kSizedBox10,
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      signUpScrnProvider.signOut(context);
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ),
                kSizedBox10,
                const Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                kSizedBox10,
                const CircleAvatar(
                  radius: 60,
                ),
                kSizedBox50,
                const Text(
                  'useremail@gmail.com',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
