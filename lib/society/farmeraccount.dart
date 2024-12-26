import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FarmerListPage extends StatefulWidget {
  @override
  _FarmerListPageState createState() => _FarmerListPageState();
}

class _FarmerListPageState extends State<FarmerListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      
        appBar: AppBar(
          title: const Text('Farmers Management'),
          backgroundColor: Colors.green.shade700,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FarmerListTab(status: 'Pending'),
            FarmerListTab(status: 'Approved'),
          ],
        ),
      ),
    );
  }
}

class FarmerListTab extends StatelessWidget {
  final String status;

  FarmerListTab({required this.status});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('farmer')
          .where('status', isEqualTo: status)
          .snapshots(),
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
          return Center(
            child: Text(
              'No $status farmers found.',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final farmers = snapshot.data!.docs;

        return ListView.builder(
          itemCount: farmers.length,
          itemBuilder: (context, index) {
            final farmerDoc = farmers[index];
            final farmerId = farmerDoc.id;
            final farmerData = farmerDoc.data() as Map<String, dynamic>;

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade700,
                  child: Text(
                    farmerData['name'] != null && farmerData['name']!.isNotEmpty
                        ? farmerData['name']![0].toUpperCase()
                        : '?',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  farmerData['name'] ?? 'N/A',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${farmerData['email'] ?? 'N/A'}'),
                    Text('Phone: ${farmerData['phone'] ?? 'N/A'}'),
                    Text('No. of cows: ${farmerData['cow'] ?? 'N/A'}'),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateFarmerPage(
                        farmerId: farmerId,
                        farmerData: farmerData,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class UpdateFarmerPage extends StatelessWidget {
  final String farmerId;
  final Map<String, dynamic> farmerData;

  const UpdateFarmerPage({
    required this.farmerId,
    required this.farmerData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Farmer: ${farmerData['name'] ?? 'N/A'}'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Center(
        child: Text('Update details for ${farmerData['name']}'),
      ),
    );
  }
}
