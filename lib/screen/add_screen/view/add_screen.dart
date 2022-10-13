import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/constents/constant_widgets/const_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({
    super.key,
    required this.screenAction,
  });

  final ScreenAction screenAction;

  @override
  Widget build(BuildContext context) {
    final addScrnProvider =
        Provider.of<AddScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kBlack,
          ),
          onPressed: () {
            addScrnProvider.popFunction(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                screenAction == ScreenAction.add
                    ? 'Add Student'
                    : 'Edit Student',
                style: const TextStyle(color: kBlack, fontSize: 22),
              ),
              kSizedBox30,
              const CircleAvatar(
                radius: 70,
              ),
              kSizedBox10,
              ConstTextFormField(
                controller: addScrnProvider.nameController,
                hint: 'Name',
              ),
              kSizedBox10,
              ConstTextFormField(
                controller: addScrnProvider.classController,
                hint: 'class',
              ),
              kSizedBox10,
              ConstTextFormField(
                controller: addScrnProvider.ageController,
                hint: 'Age',
              ),
              kSizedBox10,
              ConstTextFormField(
                controller: addScrnProvider.domainController,
                hint: 'Domain',
              ),
              kSizedBox20,
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await addScrnProvider.addStudentToFirestore(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
