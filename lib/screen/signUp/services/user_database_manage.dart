import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_student_app/constents/constant_widgets/show_snack_bar.dart';
import 'package:firebase_student_app/screen/signUp/model/user_model.dart';

class UserDatabaseManage {
  Future<void> postUserDataToFirestore(context, String name, String email,
      String password, FirebaseAuth auth) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = auth.currentUser;
      UserModel userModel = UserModel(
        uid: user!.uid,
        name: name,
        email: email,
        password: password,
      );

      await firebaseFirestore.collection('Users').doc(user.uid).set(
            userModel.toMap(),
          );
    } catch (e) {
      showSnackBarWidget(
        context,
        e.toString(),
      );
    }
  }
}
