import 'package:firebase_student_app/constents/constant_widgets/const_text_form_field.dart';
import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/signUp/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
   SignInPage({super.key});

  final signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signInProvider =
        Provider.of<SignUpScreenProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: signInFormKey,
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
                  return signInProvider.emailValidation(value);
                },
                controller: signInProvider.emailController,
                hint: 'Email',
              ),
              kSizedBox10,
              ConstTextFormField(
                validation: (String? value) {
                  return signInProvider.nameClassDomainValidation(
                      value, 'Please enter password');
                },
                controller: signInProvider.passwordController,
                hint: 'Password',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    signInProvider.onClickForgottButton(context);
                  },
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.all(0),
                    minimumSize: const Size(50, 30),
                  ),
                  child: const Text('Forgot Password'),
                ),
              ),
              kSizedBox20,
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (signInFormKey.currentState!.validate()) {
                      await signInProvider.signIn(context);
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              kSizedBox50,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not registerd yet? '),
                  TextButton(
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(50, 25),
                    ),
                    onPressed: () {
                      signInProvider.signUpTextButtonOnPressed(context);
                    },
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
      ),
    );
  }
}
