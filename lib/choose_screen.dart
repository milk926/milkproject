import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:milkproject/farmer/page/farmer_registration_page.dart';
import 'package:milkproject/society/page/society_registration.dart';
import 'package:milkproject/user/page/signup_page.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.5), // Low-opacity AppBar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 33, 150, 243),
              Color.fromARGB(255, 33, 150, 243)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo and "Purely Dairy Society" Text

                const SizedBox(height: 20),
                // Title
                const Text(
                  'Select Your Role',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 12, 12),
                  ),
                ),
                const SizedBox(height: 40),

                // Farmer Card
                buildBlurredCard(
                  context,
                  title: 'Farmer',
                  description:
                      'Manage your farm and milk supplies effortlessly.',
                  icon: Icons.agriculture,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FarmerRegistrationScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // User Card
                buildBlurredCard(
                  context,
                  title: 'User',
                  description: 'Access milk products and services with ease.',
                  icon: Icons.person,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserSignupPage(),
                      ),
                    );
                  },
                ),
                const Spacer(),
                // Admin Button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                    opacity: 0.7, // Reduced opacity
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SocietyLockPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Admin',
                        style: TextStyle(
                          fontSize: 8,
                          color: Color.fromARGB(144, 6, 60, 5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build cards with blurred borders
  Widget buildBlurredCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Icon
                  CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    radius: 30,
                    child: Icon(
                      icon,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Text Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
