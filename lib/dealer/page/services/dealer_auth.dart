import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/dealer/page/dealer_homepage.dart';
import 'package:milkproject/dealer/page/dealer_registration_page.dart';
//import 'package:firebase_core/firebase_core.dart';

class DealerAuth {
  final firebaseAuth = FirebaseAuth.instance;

  final fireStoreDatabase = FirebaseFirestore.instance;

  Future<void> DealerRegistrationScreen({
    required BuildContext context,
    required String name,
    required String contactnumber,
    required String aadharnumber,
    required String email,
    required String password,
  }) async {
    try {
      final user = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(user.user?.uid);

      await fireStoreDatabase.collection('delar').doc(user.user?.uid).set({
        'name': name,
        'contactnumber': contactnumber,
        'aadharnumber': aadharnumber,
        'email': email,
        'password': password,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('registration successfull'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration failed'),
      ));
    }
  }
}
