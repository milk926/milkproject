import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:milkproject/login_page.dart';
import 'package:milkproject/farmer/page/HomePage.dart';
import 'package:milkproject/society/page/homepage.dart';
import 'package:milkproject/user/page/user_home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize Animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    // Navigate to the appropriate screen after checking SharedPreferences
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final userRole = prefs.getString('user_role');
    print(userRole);

    Timer(const Duration(seconds: 3), () {
      if (userRole == null) {
        // Navigate to Login Page if role is not set
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      } else {
        // Navigate to the screen based on the role
        switch (userRole) {
          case 'user':
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => MilkProductPage(cartProducts: []),
              ),
            );
            break;
          case 'society':
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MilkProjectHomePage()),
            );
            break;
          case 'farmer':
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => FarmerHome()),
            );
            break;
          default:
            // If the role is unknown, navigate to Login Page
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'asset/logo.png', // Replace with your logo image path
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
