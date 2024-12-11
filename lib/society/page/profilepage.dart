import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Society Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // User Icon
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Individual Cards for Each Detail
              buildDetailCard(
                icon: Icons.location_city,
                label: 'Building Address',
                value: '123 Society Lane, Green Valley',
              ),
              buildDetailCard(
                icon: Icons.location_on,
                label: 'Location',
                value: 'Green Valley, Metropolis',
              ),
              buildDetailCard(
                icon: Icons.pin_drop,
                label: 'Pincode',
                value: '123456',
              ),
              buildDetailCard(
                icon: Icons.phone,
                label: 'Contact Number',
                value: '+91 9876543210',
              ),
              buildDetailCard(
                icon: Icons.confirmation_number,
                label: 'License Number',
                value: 'LIC-20231234',
              ),
              buildDetailCard(
                icon: Icons.person_outline,
                label: 'Manager Name',
                value: 'John Doe',
              ),
              buildDetailCard(
                icon: Icons.phone_android,
                label: 'Manager Contact Number',
                value: '+91 9876501234',
              ),
              buildDetailCard(
                icon: Icons.email,
                label: 'Email ID',
                value: 'society@example.com',
              ),
              const SizedBox(height: 30),
              // Logout Button
              ElevatedButton(
                onPressed: () {
                  // Perform logout logic here
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build individual detail cards
  Widget buildDetailCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.green.withOpacity(0.5), width: 2),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green, size: 30),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
