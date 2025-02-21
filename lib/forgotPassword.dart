import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendPasswordResetEmail() async {
    final String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter your email address.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      // Check if the user exists in the Firestore
      final userQuery = await firestore
          .collection('user') // Replace with the correct collection name
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // User exists; send a password reset email
        await _firebaseAuth.sendPasswordResetEmail(email: email);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Reset link sent. Check your email to reset your password.'),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
        }
      } else {
        // User does not exist
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not found. Please try again.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Stack(
        children: [
          // Background Image
          // Background Color
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Foreground Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Circular Logo
                    const SizedBox(height: 24),

                    // Email Text Field
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Forgot Password Button
                    ElevatedButton(
                      onPressed: sendPasswordResetEmail,
                      child: const Text('Forgot Password'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
