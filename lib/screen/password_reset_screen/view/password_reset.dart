import 'package:firebase_student_app/constents/constant_widgets/const_text_form_field.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/password_reset_screen/controller/password_reset_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordResetScreen extends StatelessWidget {
  PasswordResetScreen({super.key});

  final resetFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final resetController =
        Provider.of<PasswordResetProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            const SizedBox(
              height: 100,
              child: Image(
                image: AssetImage('lib/assets/dlt.png'),
              ),
            ),
            kSizedBox20,
            const Text(
              'Forgot Your\nPassword?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            kSizedBox10,
            const Text('Please enter your registerd email below'),
            kSizedBox30,
            Form(
              key: resetFormKey,
              child: ConstTextFormField(
                hint: 'Email',
                controller: resetController.passwordResetController,
                validation: (String? value) {
                  return resetController.emailValidation(value);
                },
              ),
            ),
            kSizedBox10,
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  if (resetFormKey.currentState!.validate()) {
                    resetController.sendEmailLink();
                    showSnackBarWidget(
                        context,
                        'A link to reset your password has been sent\n Please check your email inbox or Spam',
                        Colors.green);
                    resetController.afterClickSubmitButton(context);
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
