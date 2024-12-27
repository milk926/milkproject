import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

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
          backgroundColor: Colors.blue.shade700,
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
    final isPending = status == 'Pending';

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('farmer')
          .where('isapproved', isEqualTo: !isPending)
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade700,
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isPending)
                          ElevatedButton(
                            onPressed: () =>
                                _updateFarmerStatus(farmerId, true, context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('Approve'),
                          ),
                        if (isPending)
                          ElevatedButton(
                            onPressed: () =>
                                _updateFarmerStatus(farmerId, false, context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Reject'),
                          ),
                        TextButton(
                          onPressed: () {
                            _viewDocument(context, farmerData);
                          },
                          child: const Text(
                            'View Document',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _updateFarmerStatus(
      String farmerId, bool approve, BuildContext context) async {
    try {
      await _firestore.collection('farmer').doc(farmerId).update({
        'isapproved': approve,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              approve ? 'Farmer approved successfully.' : 'Farmer rejected.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update farmer status: $e')),
      );
    }
  }

  void _viewDocument(BuildContext context, Map<String, dynamic> farmerData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentViewerPage(farmerData: farmerData),
      ),
    );
  }
}

class DocumentViewerPage extends StatelessWidget {
  final Map<String, dynamic> farmerData;

  const DocumentViewerPage({required this.farmerData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final documentUrl = farmerData['document_url'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Document: ${farmerData['name'] ?? 'N/A'}'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: documentUrl == null || documentUrl.isEmpty
          ? const Center(
              child: Text(
                'No document available.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : Center(
              child: Image.network(
                documentUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'Failed to load document.',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
