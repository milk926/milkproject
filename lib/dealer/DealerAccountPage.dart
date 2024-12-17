import 'package:flutter/material.dart';
import 'package:milkproject/dealer/page/dealer_editProfile.dart';
import 'package:milkproject/dealer/page/dealer_homepage.dart';
import 'package:milkproject/login_page.dart';

class DealerAccountPage extends StatelessWidget {
  final String dealerEmail;
  final String dealerName;
  final String dealerPhone;
  final String dealerLocation;
  final dynamic dealer; // Nullable

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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Action to edit profile
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DealerEditProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Profile Icon at the Center
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xFF3EA120),
                child: const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Account Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildDetailCard('Name', dealerName),
            _buildDetailCard('Email', dealerEmail),
            _buildDetailCard('Phone', dealerPhone),
            _buildDetailCard('Location', dealerLocation),
            const SizedBox(height: 30),
            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                _showLogoutDialog(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color(0xFFEAF7E4),
        child: ListTile(
          title:
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(value),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LogIn()),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

class Dealer {}
