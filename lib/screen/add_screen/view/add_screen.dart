import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/constents/constant_widgets/const_text_form_field.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
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
    final homeScreenProvider = Provider.of<HomeScreenProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (screenAction == ScreenAction.edit) {
        addScrnProvider.fillEditScreen(model, screenAction);
      }
      // else {
      //   addScrnProvider.clearControllers();
      // }
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
            key: addScrnProvider.formKey,
            child: Consumer<AddScreenProvider>(
              builder: (BuildContext ctx, value, Widget? _) {
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
                    CircleAvatar(
                      backgroundImage: screenAction == ScreenAction.edit
                          ? addScrnProvider.passedImage != ""
                              ? NetworkImage(addScrnProvider.passedImage)
                              : null
                          : null,
                      radius: 70,
                      child: addScrnProvider.studentImage == null
                          ? GestureDetector(
                              onTap: () {
                                addScrnProvider.pickStudentImage(context);
                              },
                              child: screenAction == ScreenAction.add
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.camera_alt),
                                        Text('Add Image')
                                      ],
                                    )
                                  : Align(
                                      alignment: Alignment.bottomCenter,
                                      child: TextButton(
                                        onPressed: () {
                                          addScrnProvider
                                              .pickStudentImage(context);
                                        },
                                        child: const Text(
                                          'Change\nimage',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                            )
                          : CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  FileImage(addScrnProvider.studentImage!),
                            ),
                    ),
                    kSizedBox10,
                    ConstTextFormField(
                      validation: (String? values) {
                        // if (values == null || values.isEmpty) {
                        //   return 'Please enter name';
                        // }
                        return value.nameClassDomainValidation(
                            values, 'Please enter name');
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
                        return value.nameClassDomainValidation(
                            values, 'Please enter class');
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
                        return value.nameClassDomainValidation(
                            values, 'Please enter domain name');
                      },
                      controller: value.domainController,
                      hint: 'Domain',
                    ),
                    kSizedBox20,
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          value.onClickSaveButton(screenAction, context, model);
                          homeScreenProvider.getStudentList();
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
