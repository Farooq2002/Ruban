import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String workCompany;
  final String jobRole;
  final String language;
  String imageUrl;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.workCompany,
      required this.jobRole,
      required this.language,
      required this.imageUrl});
  factory UserModel.fromSnapShot(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return UserModel(
        firstName: snapShot['firstname'],
        lastName: snapShot['lastname'],
        email: snapShot['email'],
        phoneNumber: snapShot['phoneNumber'],
        workCompany: snapShot['workCompany'],
        jobRole: snapShot['jobRole'],
        language: snapShot['languages'],
        imageUrl: snapShot['imageUrl']);
  }
  Map<String, dynamic> toJson() => {
        "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "workCompany": workCompany,
        "jobRole": jobRole,
        "language": language,
        "imageUrl": imageUrl
      };
}
