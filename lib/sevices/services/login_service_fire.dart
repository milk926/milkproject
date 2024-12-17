import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/dealer/page/dealer_homepage.dart';
import 'package:milkproject/farmer/page/farmer_home_page.dart';
import 'package:milkproject/society/page/homepage.dart';
import 'package:milkproject/user/page/user_buynow.dart';

class LoginServiceFire {
  final firebaseAuth = FirebaseAuth.instance;
  final firestoreDatabse = FirebaseFirestore.instance;

  Future<void> LoginService({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Sign in with email and password
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful')),
        );
        final role = await firestoreDatabse
            .collection('role_tb')
            .where('uid', isEqualTo: userCredential.user?.uid)
            .get();

        final roledata = role.docs.first.data();

        switch (roledata['role']) {
          case 'user':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MilkProductPage(cartProducts: []),
              ),
            );
            break;
          case 'society':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MilkProjectHomePage(),
              ),
            );
            break;
          case 'farmer':
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return FarmerChoiceScreen();
              },
            ));
            break;
          case 'dealer':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DealerHomePage(),
              ),
            );
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Role not recognized')),
            );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  }
}