import 'package:firebase_student_app/constents/constant_widgets/const_text_form_field.dart';
import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/signUp/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider =
        Provider.of<SignUpScreenProvider>(context, listen: false);

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
              validation: (String? value) {
                return null;
              },
              controller: signUpProvider.emailController,
              hint: 'Email',
            ),
            kSizedBox10,
            ConstTextFormField(
              validation: (String? value) {
                return null;
              },
              controller: signUpProvider.passwordController,
              hint: 'Password',
            ),
            kSizedBox20,
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await signUpProvider.signIn(context);
                },
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
                      signUpProvider.signUpTextButtonOnPressed(context),
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
