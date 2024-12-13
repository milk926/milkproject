import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/firebase_options.dart';
import 'package:milkproject/society/page/homepage.dart';
import 'package:milkproject/society/page/profilepage.dart';
import 'package:milkproject/user/page/buy_now.dart';
import 'package:milkproject/user/page/edit_profile.dart';
import 'package:milkproject/user/page/login_page.dart';
import 'package:milkproject/user/page/addtocart.dart';
import 'package:milkproject/user/page/signup_page.dart';
import 'package:milkproject/user/page/user_buynow.dart';
import 'package:milkproject/user/page/userprofile.dart'; // Assuming ProfileScreen is in this file

// Define a simple User class if not already defined
class User {
  String name;
  String email;
  String phone;
  int cows;

  User(
      {required this.name,
      required this.email,
      required this.phone,
      required this.cows});
}

// Main function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure proper initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen  ()
        // Pass the test user to the ProfileScreen
        ),
  );
}
