import 'package:firebase_student_app/constents/constant_widgets/confirmation_popup.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeScreenProvider>(context);
    final addScrnProvider = Provider.of<AddScreenProvider>(context);

    return GestureDetector(
      onLongPress: () => homeProvider.onLongPressedTile(index),
      onLongPressCancel: () => homeProvider.onCancelLongPressedTile(index),
      child: ListTile(
        onTap: () {
          homeProvider.onTapfunction(
            context,
            ScreenAction.edit,
            addScrnProvider.studentList[index],
          );
        },
        horizontalTitleGap: 15,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: CircleAvatar(
          radius: 20,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Text('${index + 1}'),
          ),
        ),
        title: Text(addScrnProvider.studentList[index].name!),
        subtitle: Text('Class: ${addScrnProvider.studentList[index].std!}'),
        trailing: SizedBox(
          width: 100,
          child: IconButton(
            onPressed: () => confirmationPopUp(
                context, 'Student will be deleted, Do you want to continue ?',
                () {
              addScrnProvider
                  .deleteStudent(addScrnProvider.studentList[index].studentId!);
            }),
            icon: homeProvider.visibilityList[index] == true
                ? const Icon(Icons.delete)
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
