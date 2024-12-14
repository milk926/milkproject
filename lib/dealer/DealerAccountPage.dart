// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:milkproject/dealer/page/dealer_homepage.dart';
// Correct import for DealerLoginPage
// ignore: duplicate_import
import 'package:milkproject/dealer/page/dealer_homepage.dart';

class DealerAccountPage extends StatelessWidget {
  final String dealerEmail;
  final String dealerName;
  final String dealerPhone;
  final String dealerLocation;
  final dynamic dealer; // Make this nullable

  const DealerAccountPage({
    super.key,
    required this.dealerEmail,
    required this.dealerName,
    required this.dealerPhone,
    required this.dealerLocation,
    this.dealer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        backgroundColor: const Color(0xFF3EA120),
      ),
      body: SingleChildScrollView(
        // Wrap the body inside SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildDetailCard('Name', dealerName),
              _buildDetailCard('Email', dealerEmail),
              _buildDetailCard('Phone', dealerPhone),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to registration page if needed to update details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DealerHomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3EA120),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('Edit Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xFFEAF7E4),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}

class Dealer {}
