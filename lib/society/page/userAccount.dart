import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserAccountPage extends StatefulWidget {
  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to delete a user
  Future<void> _deleteUser(String userId) async {
    try {
      await _firestore.collection('user').doc(userId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User deleted successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $e')),
      );
    }
  }

  // Function to delete a farmer
  Future<void> _deleteFarmer(String farmerId) async {
    try {
      await _firestore.collection('farmer').doc(farmerId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Farmer deleted successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete farmer: $e')),
      );
    }
  }

  // Function to view user details in a dialog
  void _viewUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('User Details: ${user['name'] ?? 'N/A'}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${user['name'] ?? 'N/A'}'),
              Text('Email: ${user['email'] ?? 'N/A'}'),
              Text('Phone: ${user['phone'] ?? 'N/A'}'),
              Text('Ration Card: ${user['ration_card'] ?? 'N/A'}'),
              Text('Bank Account: ${user['bank_account'] ?? 'N/A'}'),
              Text(
                  'Joined On: ${_formatTimestamp(user['createdAt']) ?? 'N/A'}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Function to view farmer details in a dialog
  void _viewFarmerDetails(Map<String, dynamic> farmer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Farmer Details: ${farmer['name'] ?? 'N/A'}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${farmer['name'] ?? 'N/A'}'),
              Text('Farm Name: ${farmer['farm_name'] ?? 'N/A'}'),
              Text('Phone: ${farmer['phone'] ?? 'N/A'}'),
              Text('Location: ${farmer['location'] ?? 'N/A'}'),
              Text('Products Sold: ${farmer['products'] ?? 'N/A'}'),
              Text(
                  'Registered On: ${_formatTimestamp(farmer['registeredAt']) ?? 'N/A'}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Format Firestore Timestamp to readable date
  String? _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return null;
    final DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User & Farmer Management'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // User StreamBuilder
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('user').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Failed to load users. Please try again later.',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No users found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  final users = snapshot.data!.docs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Users', style: TextStyle(fontSize: 20)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final userDoc = users[index];
                          final userId = userDoc.id;
                          final userData =
                              userDoc.data() as Map<String, dynamic>;

                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green.shade700,
                                child: Text(
                                  userData['name'] != null &&
                                          userData['name']!.isNotEmpty
                                      ? userData['name']![0].toUpperCase()
                                      : '?',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                userData['name'] ?? 'N/A',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email: ${userData['email'] ?? 'N/A'}'),
                                  Text('Phone: ${userData['phone'] ?? 'N/A'}'),
                                  Text(
                                      'Ration Card: ${userData['ration_card'] ?? 'N/A'}'),
                                  Text(
                                      'Bank Account: ${userData['bank_account'] ?? 'N/A'}'),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'View Details') {
                                    _viewUserDetails(userData);
                                  } else if (value == 'Delete') {
                                    _deleteUser(userId);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'View Details',
                                    child: Text('View Details'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'Delete',
                                    child: Text('Delete User'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              // Farmer StreamBuilder
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('farmers').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Failed to load farmers. Please try again later.',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No farmers found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  final farmers = snapshot.data!.docs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Farmers', style: TextStyle(fontSize: 20)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: farmers.length,
                        itemBuilder: (context, index) {
                          final farmerDoc = farmers[index];
                          final farmerId = farmerDoc.id;
                          final farmerData =
                              farmerDoc.data() as Map<String, dynamic>;

                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green.shade700,
                                child: Text(
                                  farmerData['name'] != null &&
                                          farmerData['name']!.isNotEmpty
                                      ? farmerData['name']![0].toUpperCase()
                                      : '?',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                farmerData['name'] ?? 'N/A',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name: ${farmerData['name'] ?? 'N/A'}'),
                                  Text(
                                      'Phone: ${farmerData['phone'] ?? 'N/A'}'),
                                  Text(
                                      'Email : ${farmerData['email'] ?? 'N/A'}'),
                                  Text(
                                      'Number of cows : ${farmerData['cows'] ?? 'N/A'}'),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'View Details') {
                                    _viewFarmerDetails(farmerData);
                                  } else if (value == 'Delete') {
                                    _deleteFarmer(farmerId);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'View Details',
                                    child: Text('View Details'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'Delete',
                                    child: Text('Delete Farmer'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
