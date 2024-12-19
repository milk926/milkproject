import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';

class FarmerAuthService {
  final firebaseAuth = FirebaseAuth.instance;

  final fireStoreDatabase = FirebaseFirestore.instance;

  Future<void> FarmerRegister(
      {required BuildContext context,
      required String name,
      required String password,
      required String phone,
      required String cow,
      required String email}) async {
    try {
      final user = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(user.user?.uid);

      await fireStoreDatabase.collection('farmer').doc(user.user?.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'cow': cow,
      });
      fireStoreDatabase
          .collection('role_tb')
          .add({'uid': user.user?.uid, 'role': 'farmers'});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration successfull'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration failed'),
      ));
    }
  }
}
