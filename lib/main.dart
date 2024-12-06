//import 'package:milkproject/user/page/login_page.dart';
//import 'package:milkproject/user/page/signup_page.dart';
//import 'package:milkproject/user/page/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/firebase_options.dart';
import 'package:milkproject/user/page/buy_now.dart';
import 'package:milkproject/user/page/login_page.dart';
import 'package:milkproject/user/page/signup_page.dart';
//import 'package:milkproject/user/page/buy_now.dart';
//import 'package:milkproject/society/page/homepage.dart';
//import 'package:milkproject/user/page/login_page.dart';


//import 'package:milkproject/society/page/homepage.dart';

// ignore: non_constant_identifier_names
Future<void>main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false, home: 
UserSignupPage() ),
  );
}



