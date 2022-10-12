class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
  });

  //User data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
