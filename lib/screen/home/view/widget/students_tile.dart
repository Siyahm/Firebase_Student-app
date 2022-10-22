import 'dart:developer';

import 'package:firebase_student_app/constents/constant_widgets/confirmation_popup.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    super.key,
    required this.index,
    required this.studentList,
  });
  final int index;
  final List<StudentModel> studentList;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeScreenProvider>(context);
    final addScrnProvider = Provider.of<AddScreenProvider>(context);
    return GestureDetector(
      onLongPress: () {
        if (homeProvider.visibilityList.isNotEmpty) {
          homeProvider.onLongPressedTile(index);
          log(homeProvider.visibilityList[index].toString());
        }
      },
      onLongPressCancel: () {
        if (homeProvider.visibilityList.isNotEmpty) {
          homeProvider.onCancelLongPressedTile(index);
          log(homeProvider.visibilityList[index].toString());
        }
      },
      child: Container(
        color: const Color.fromARGB(148, 226, 226, 226),
        child: ListTile(
          onTap: () {
            homeProvider.onTapAddButtonfunction(
              context,
              ScreenAction.edit,
              homeProvider.studentList[index],
            );
          },
          horizontalTitleGap: 15,
          contentPadding: const EdgeInsets.symmetric(horizontal: 50),
          leading: studentList[index].image == null
              ? CircleAvatar(
                  radius: 20,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Text('${index + 1}'),
                  ),
                )
              : CircleAvatar(
                  radius: 20,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(studentList[index].image!),
                  ),
                ),
          title: Text(homeProvider.studentList[index].name!),
          subtitle: Text('Class: ${homeProvider.studentList[index].std!}'),
          trailing: SizedBox(
            width: 100,
            child: GestureDetector(
              onTap: () {
                homeProvider.visibilityList[index] = true;
                homeProvider.visibilityList[index] == true
                    ? confirmationPopUp(
                        context,
                        'Student will be deleted, Do you want to continue ?',
                        () {
                          addScrnProvider.deleteStudent(
                              homeProvider.studentList[index].studentId!);
                          homeProvider.getStudentList();
                        },
                        index,
                      )
                    : const SizedBox();
              },
              child: homeProvider.visibilityList.isEmpty
                  ? const SizedBox()
                  : homeProvider.visibilityList[index] == true
                      ? const Icon(Icons.delete)
                      : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
