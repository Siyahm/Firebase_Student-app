import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/constents/constant_widgets/const_text_form_field.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({
    super.key,
    required this.screenAction,
    this.model,
  });

  final ScreenAction screenAction;
  final StudentModel? model;

  @override
  Widget build(BuildContext context) {
    final addScrnProvider =
        Provider.of<AddScreenProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addScrnProvider.fillEditScreen(model, screenAction);
    });
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
          child: Form(
            key: Provider.of<AddScreenProvider>(context, listen: false).formKey,
            child: Consumer<AddScreenProvider>(
              builder: (BuildContext context, value, Widget? _) {
                return Column(
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
                      validation: (String? values) {
                        // if (values == null || values.isEmpty) {
                        //   return 'Please enter name';
                        // }
                        return value.nameClassDomainValidation(values);
                        // return null;
                      },
                      controller: value.nameController,
                      hint: 'Name',
                    ),
                    kSizedBox10,
                    ConstTextFormField(
                      controller: value.classController,
                      hint: 'class',
                      validation: (String? values) {
                        return value.nameClassDomainValidation(values);
                      },
                    ),
                    kSizedBox10,
                    ConstTextFormField(
                      validation: (String? values) {
                        return value.ageValidation(values);
                      },
                      controller: value.ageController,
                      hint: 'Age',
                    ),
                    kSizedBox10,
                    ConstTextFormField(
                      validation: (String? values) {
                        return value.nameClassDomainValidation(values);
                      },
                      controller: value.domainController,
                      hint: 'Domain',
                    ),
                    kSizedBox20,
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (value.formKey.currentState!.validate()) {
                            screenAction == ScreenAction.add
                                ? await value.addStudentToFirestore(context)
                                : await value.updateStudentToFirestore(
                                    context, model!.studentId!);
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
