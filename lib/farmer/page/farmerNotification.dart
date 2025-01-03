import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FarmerNotificationPage extends StatelessWidget {
  FarmerNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 111, 255),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<User?>(
        future: Future.value(auth.currentUser),
        builder: (context, authSnapshot) {
          if (!authSnapshot.hasData) {
            return const Center(child: Text('User not logged in.'));
          }

          final currentUser = authSnapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Farmer Market Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection('FarmerMarket')
                        .where('sellerId', isEqualTo: currentUser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Notifications',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }

                      final notifications = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          final data =
                              notification.data() as Map<String, dynamic>;

                          return _buildNotificationCard(
                            firestore: firestore,
                            sellerId: currentUser.uid,
                            notificationId: notification.id,
                            buyerId: data['buyerId'] ?? '',
                            imageUrl: data['imageUrl'] ?? '',
                            productName:
                                data['productName'] ?? 'Unknown Product',
                            productDescription:
                                data['productDescription'] ?? '',
                            timestamp: data['timestamp'] ?? '',
                            onAccept: () => _handleAccept(
                              firestore,
                              currentUser.uid,
                              notification.id,
                              data['buyerId'] ?? '',
                            ),
                            onReject: () =>
                                _handleReject(firestore, notification.id),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'General Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection('farmerNotification')
                        .where('buyerId', isEqualTo: currentUser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No General Notifications',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }

                      final notifications = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          final data =
                              notification.data() as Map<String, dynamic>;

                          return FutureBuilder<String>(
                            future: _getSellerName(
                                firestore, data['sellerId'] ?? ''),
                            builder: (context, nameSnapshot) {
                              final sellerName = nameSnapshot.data ?? 'Unknown';
                              return _buildGeneralNotificationCard(
                                message: data['message'] ?? 'No message',
                                sellerName: sellerName,
                                timestamp: data['timestamp'] ?? '',
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Notification card widget for FarmerMarket
  Widget _buildNotificationCard({
    required FirebaseFirestore firestore,
    required String sellerId,
    required String notificationId,
    required String buyerId,
    required String imageUrl,
    required String productName,
    required String productDescription,
    required dynamic timestamp,
    required VoidCallback onAccept,
    required VoidCallback onReject,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 50),
                  ),
            const SizedBox(height: 12),
            Text(
              'Product: $productName',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Description: $productDescription',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Text(
              'Buyer ID: $buyerId',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Text(
              'Time: ${_formatTimestamp(timestamp)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // General notification card widget for farmerNotification
  Widget _buildGeneralNotificationCard({
    required String message,
    required String sellerName,
    required dynamic timestamp,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Seller: $sellerName',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              'Time: ${_formatTimestamp(timestamp)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleAccept(
    FirebaseFirestore firestore,
    String sellerId,
    String notificationId,
    String buyerId,
  ) async {
    try {
      await firestore
          .collection('FarmerMarket')
          .doc(notificationId)
          .update({'status': 'Accepted'});
      await firestore.collection('farmerNotification').add({
        'message': 'Your buy request has been accepted',
        'sellerId': sellerId,
        'buyerId': buyerId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Delete the notification after accepting it
      await firestore.collection('FarmerMarket').doc(notificationId).delete();
    } catch (e) {
      print('Error handling accept: $e');
    }
  }

  Future<void> _handleReject(
      FirebaseFirestore firestore, String notificationId) async {
    try {
      await firestore
          .collection('FarmerMarket')
          .doc(notificationId)
          .update({'status': 'Rejected'});

      // Delete the notification after rejecting it
      await firestore.collection('FarmerMarket').doc(notificationId).delete();
    } catch (e) {
      print('Error handling reject: $e');
    }
  }

  Future<String> _getSellerName(
      FirebaseFirestore firestore, String sellerId) async {
    try {
      final sellerDoc =
          await firestore.collection('farmer').doc(sellerId).get();
      if (sellerDoc.exists) {
        return sellerDoc.data()?['name'] ?? 'Unknown';
      } else {
        return 'Unknown';
      }
    } catch (e) {
      print('Error fetching seller name: $e');
      return 'Unknown';
    }
  }

  String _formatTimestamp(dynamic timestamp) {
    try {
      DateTime parsedTimestamp;
      if (timestamp is Timestamp) {
        parsedTimestamp = timestamp.toDate();
      } else if (timestamp is String) {
        parsedTimestamp = DateTime.parse(timestamp);
      } else {
        return 'Invalid time';
      }

      final Duration difference = DateTime.now().difference(parsedTimestamp);

      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} mins ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hours ago';
      } else {
        return '${difference.inDays} days ago';
      }
    } catch (e) {
      return 'Invalid time';
    }
  }
}
