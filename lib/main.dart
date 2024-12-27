// ignore_for_file: unused_import

import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/farmer/page/farmer_registration_page.dart';
import 'package:milkproject/firebase_options.dart';
import 'package:milkproject/login_page.dart';
import 'package:milkproject/splash_screen.dart';
// Assuming ProfileScreen is in this file

// Main function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure proper initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
     MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()
        // Pass the test user to the ProfileScreen
        ),
  );
}
