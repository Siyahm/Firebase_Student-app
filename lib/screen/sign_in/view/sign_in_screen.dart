import 'package:firebase_student_app/constents/constant_widgets/const_text_form_field.dart';
import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/sign_in/controller/sign_in_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signInProvider =
        Provider.of<SignInScreenProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign in',
              style: TextStyle(color: kBlack, fontSize: 22),
            ),
            kSizedBox50,
            ConstTextFormField(
              controller: signInProvider.emailController,
              hint: 'Email',
            ),
            kSizedBox10,
            ConstTextFormField(
              controller: signInProvider.passwordController,
              hint: 'Password',
            ),
            kSizedBox20,
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.all(0),
                  minimumSize: const Size(50, 30),
                ),
                child: const Text('Forgot Password'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Not registerd yet? '),
                TextButton(
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.all(0),
                    minimumSize: const Size(50, 25),
                  ),
                  onPressed: () =>
                      signInProvider.signUpButtonOnPressed(context),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: kBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
