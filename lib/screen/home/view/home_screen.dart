import 'dart:developer';

import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/screen/add_screen/model/sutdents_model.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:firebase_student_app/screen/home/view/widget/custom_drawer.dart';
import 'package:firebase_student_app/screen/home/view/widget/students_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  StudentModel? model;
  @override
  Widget build(BuildContext context) {
    final homeScrnProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    final addScrnProvider =
        Provider.of<AddScreenProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeScrnProvider.getUser(context);
      // addScrnProvider.getStudentList();
    });
    log("jj");
    return Scaffold(
      key: homeScrnProvider.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Students',
          style: TextStyle(
            color: kBlue,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: kBlack,
            ),
            onPressed: () {
              addScrnProvider.clearControllers();
              homeScrnProvider.onTapfunction(
                context,
                ScreenAction.add,
                model,
              );
            },
          ),
          kSizedBoxWidth10,
          GestureDetector(
            onTap: () =>
                homeScrnProvider.scaffoldKey.currentState!.openEndDrawer(),
            child: Consumer<HomeScreenProvider>(
                builder: (BuildContext context, value, Widget? child) {
              return CircleAvatar(
                child: value.isLoading == true
                    ? const CircularProgressIndicator()
                    : Text(
                        value.userModel?.name?[0].toString().toUpperCase() ??
                            "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
              );
            }),
          ),
          kSizedBoxWidth10,
        ],
      ),
      endDrawer: const CustomDrawer(),
      body: Consumer<AddScreenProvider>(
        builder: (context, value, child) => ListView.separated(
            itemBuilder: (context, index) => StudentTile(
                  index: index,
                ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: value.studentList.length),
      ),
    );
  }
}
