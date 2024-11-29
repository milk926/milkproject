//import 'package:milkproject/user/page/login_page.dart';
//import 'package:milkproject/user/page/signup_page.dart';
//import 'package:milkproject/user/page/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/firebase_options.dart';
import 'package:milkproject/user/page/user_buynow.dart';
//import 'package:milkproject/society/page/homepage.dart';
//import 'package:milkproject/user/page/buy_now.dart';

//import 'farmer/page/farmer_profile_page.dart';

//import 'package:milkproject/society/page/homepage.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: MilkProductPage()),
  );
}
