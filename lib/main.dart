import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_student_app/screen/add_screen/controller/add_screen_provider.dart';
import 'package:firebase_student_app/screen/home/controller/home_screen_provider.dart';
import 'package:firebase_student_app/screen/home/view/home_screen.dart';
import 'package:firebase_student_app/screen/sign_in/controller/sign_in_screen_controller.dart';

import 'package:firebase_student_app/screen/signUp/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignInScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddScreenProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
