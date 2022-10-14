import 'package:firebase_student_app/constents/constant_widgets/const_text_form_field.dart';
import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/signUp/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSignUp extends StatelessWidget {
  const ScreenSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpScrnProvider =
        Provider.of<SignUpScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            signUpScrnProvider.popFunction(context);
            signUpScrnProvider.clearControllers();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Register',
              style: TextStyle(color: kBlack, fontSize: 22),
            ),
            kSizedBox50,
            ConstTextFormField(
              validation: (String? value) {
                return null;
              },
              hint: 'Name',
              controller: signUpScrnProvider.nameController,
            ),
            kSizedBox10,
            ConstTextFormField(
              validation: (String? value) {
                return null;
              },
              hint: 'Email',
              controller: signUpScrnProvider.emailController,
            ),
            kSizedBox10,
            ConstTextFormField(
              validation: (String? value) {
                return null;
              },
              hint: 'Password',
              controller: signUpScrnProvider.passwordController,
            ),
            kSizedBox20,
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await signUpScrnProvider.signUp(context);
                },
                child: const Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
