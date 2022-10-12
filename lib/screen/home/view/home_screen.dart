import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:firebase_student_app/screen/home/view/widget/custom_drawer.dart';
import 'package:firebase_student_app/screen/home/view/widget/students_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScrnProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
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
              homeScrnProvider.onTapfunction(context, ScreenAction.add);
            },
          ),
          kSizedBoxWidth10,
          GestureDetector(
            onTap: () =>
                homeScrnProvider.scaffoldKey.currentState!.openEndDrawer(),
            child: const CircleAvatar(),
          ),
          kSizedBoxWidth10,
        ],
      ),
      endDrawer: const CustomDrawer(),
      body: ListView.separated(
          itemBuilder: (context, index) => StudentTile(
                index: index,
              ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 10),
    );
  }
}
