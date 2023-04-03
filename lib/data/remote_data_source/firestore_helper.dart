import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ruban/data/models/user_model.dart';

class FireStoreHelper {
  static Stream<List<UserModel>> read() {
    final userCollection = FirebaseFirestore.instance.collection("user");

    return userCollection.snapshots().map((querySnapShot) =>
        querySnapShot.docs.map((e) => UserModel.fromSnapShot(e)).toList());
  }

  static Future create(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("user");
    final docRef = userCollection.doc();
    final newUser = UserModel(
            firstName: user.firstName,
            lastName: user.lastName,
            email: user.email,
            phoneNumber: user.phoneNumber,
            workCompany: user.workCompany,
            jobRole: user.jobRole,
            language: user.language,
            imageUrl: user.imageUrl)
        .toJson();
    try {
      await docRef.set(newUser);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
