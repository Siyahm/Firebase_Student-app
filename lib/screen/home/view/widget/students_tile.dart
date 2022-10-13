import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({super.key, required this.index});
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
        horizontalTitleGap: -5,
        contentPadding: const EdgeInsets.all(0),
        leading: const CircleAvatar(
          radius: 50,
        ),
        title: Text(addScrnProvider.studentList[index].name!),
        subtitle: Text('Class: ${addScrnProvider.studentList[index].std!}'),
        trailing: SizedBox(
          width: 100,
          child: IconButton(
            onPressed: (() {}),
            icon: homeProvider.visibilityList[index] == true
                ? const Icon(Icons.delete)
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
