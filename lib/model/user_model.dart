import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userName;
  String? email;
  String? profilePic;

  UserModel({this.userName, this.email, this.profilePic});

  UserModel.fromSnamshot(DocumentSnapshot<Map<String, dynamic>> data) {
    userName = data.data()!["user_name"];
    email = data.data()!['email'];
    profilePic = data.data()!['profile_pic'];

    print('email is $email');
  }
}
