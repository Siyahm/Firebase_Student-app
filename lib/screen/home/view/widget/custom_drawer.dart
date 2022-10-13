import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:firebase_student_app/screen/signUp/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpScrnProvider =
        Provider.of<SignUpScreenProvider>(context, listen: false);
    final homeScrnProvider = Provider.of<HomeScreenProvider>(context);

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
                Text(
                  context.read<HomeScreenProvider>().userModel!.name.toString(),
                  //homeScrnProvider.userModel?.name ?? 'User',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                kSizedBox10,
                const CircleAvatar(
                  radius: 60,
                ),
                kSizedBox50,
                Text(
                  homeScrnProvider.userModel?.email ?? 'Email:',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
