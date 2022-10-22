import 'package:firebase_student_app/constents/constents.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_or_edit_enum.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:firebase_student_app/screen/home/view/widget/custom_drawer.dart';
import 'package:firebase_student_app/screen/home/view/widget/students_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeScrnProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    // final addScrnProvider =
    //     Provider.of<AddScreenProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeScrnProvider.getUser(context);
      homeScrnProvider.getStudentList();
    });
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
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
          kSizedBoxWidth10,
          GestureDetector(
            onTap: () => scaffoldKey.currentState!.openEndDrawer(),
            child: Consumer<HomeScreenProvider>(
                builder: (BuildContext context, value, Widget? child) {
              return value.isLoading == true
                  ? const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      child: CircularProgressIndicator())
                  : value.downloadUrl != null
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(value.downloadUrl!),
                        )
                      : CircleAvatar(
                          child: Text(
                            value.userModel?.name?[0]
                                    .toString()
                                    .toUpperCase() ??
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeScrnProvider.onTapAddButtonfunction(
            context,
            ScreenAction.add,
            homeScrnProvider.model,
          );
          Provider.of<AddScreenProvider>(context, listen: false)
              .clearControllers();
        },
        child: const Icon(Icons.add),
      ),
      endDrawer: const CustomDrawer(),
      body: Consumer<HomeScreenProvider>(
        builder: (context, value, child) {
          if (value.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.studentList.isEmpty) {
            return const Center(
              child: Text('No students added'),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) => StudentTile(
                    index: index,
                    studentList: value.studentList,
                  ),
              separatorBuilder: (context, index) => const Divider(
                    height: 5,
                  ),
              itemCount: value.studentList.length);
        },
      ),
    );
  }
}
