//import 'package:milkproject/user/page/login_page.dart';
//import 'package:milkproject/user/page/signup_page.dart';
//import 'package:milkproject/user/page/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/society/page/homepage.dart';

//import 'farmer/page/farmer_profile_page.dart';
>>>>>>> b59dabfeb644486cee45e483280b6ceabb7baf7f

//import 'package:milkproject/society/page/homepage.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: MilkProjectHomePage()),
  );
}
