// ignore_for_file: unused_import

import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:milkproject/farmer/page/farmer_registration_page.dart';
import 'package:milkproject/firebase_options.dart';
import 'package:milkproject/login_page.dart';
import 'package:milkproject/splash_screen.dart';

const API = 'AIzaSyCQRkPILWqFh25RkX33Wx2r1RwoMEg0oSg';
// Assuming ProfileScreen is in this file

// Main function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure proper initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Gemini.init(apiKey: API);
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()
        // Pass the test user to the ProfileScreen
        ),
  );
}
