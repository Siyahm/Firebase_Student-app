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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: signUpScrnProvider.signUpFormKey,
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
                    return signUpScrnProvider.nameClassDomainValidation(
                        value, 'Please enter name');
                  },
                  hint: 'Name',
                  controller: signUpScrnProvider.nameController,
                ),
                kSizedBox10,
                ConstTextFormField(
                  validation: (String? value) {
                    return signUpScrnProvider.emailValidation(value);
                  },
                  hint: 'Email',
                  controller: signUpScrnProvider.emailController,
                ),
                kSizedBox10,
                ConstTextFormField(
                  validation: (String? value) {
                    return signUpScrnProvider.passwordValidation(value);
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
                      if (signUpScrnProvider.signUpFormKey.currentState!
                          .validate()) {
                        await signUpScrnProvider.signUp(context);
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
                kSizedBox50,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    TextButton(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.all(0),
                        minimumSize: const Size(50, 25),
                      ),
                      onPressed: () {
                        signUpScrnProvider.popFunction(context);
                      },
                      child: const Text(
                        'Sign In',
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
      ),
    );
  }
}
