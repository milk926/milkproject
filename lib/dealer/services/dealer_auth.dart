import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/dealer/page/dealer_homepage.dart';
import 'package:milkproject/user/page/user_buynow.dart';

class DealerAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStoreDatabase = FirebaseFirestore.instance;

  Future<void> dealerRegister({
    required BuildContext context,
    required String name,
    required String password,
    required String aadhar,
    required String phone,
    required String email,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = userCredential.user?.uid;

      if (userId != null) {
        await fireStoreDatabase.collection('dealer').doc(userId).set({
          'name': name,
          'email': email,
          'phone': phone,
          'aadhar': aadhar,
          'password': password,
        });
        fireStoreDatabase
            .collection('role_tb')
            .add({'uid': userCredential.user?.uid, 'role': 'dealer'});

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful'),
          ),
        );

        // Navigate to HomePage after successful registration
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const DealerHomePage()),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.toString()}'),
        ),
      );
    }
  }
}
