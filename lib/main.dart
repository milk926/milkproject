import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/dealer/dealerUpdateLocation.dart';
import 'package:milkproject/dealer/page/dealer_homepage.dart';
import 'package:milkproject/dealer/page/dealer_registration_page.dart';
import 'package:milkproject/firebase_options.dart';

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

  // Example user for testing
  User testUser = User(
    name: 'John Doe',
    email: 'johndoe@example.com',
    phone: '+919876543210',
    cows: 50,
  );

  runApp(
    const MaterialApp(
        debugShowCheckedModeBanner: false, home: UpdateLocationPage()),
  );
}
