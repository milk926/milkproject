import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Dealer class to represent the dealer's information
class Dealer {
  final String name;

  Dealer(this.name);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dealer App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false, // Removes the "DEBUG" banner
      home: const DealerLoginPage(),
    );
  }
}

class DealerLoginPage extends StatelessWidget {
  const DealerLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulating a dealer login
    Dealer dealer = Dealer('John Doe'); // Example dealer name

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Login'),
        backgroundColor: const Color(0xFF3EA120),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to DealersHomepage and pass dealer object
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DealersHomepage(dealer: dealer),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3EA120), // Green background
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text('Go to Homepage'),
        ),
      ),
    );
  }
}

class DealersHomepage extends StatefulWidget {
  final Dealer dealer;

  const DealersHomepage({super.key, required this.dealer});

  @override
  _DealersHomepageState createState() => _DealersHomepageState();
}

class _DealersHomepageState extends State<DealersHomepage> {
  int _notificationCount = 3; // Start with 3 notifications for demo purposes

  void _incrementNotification(String message) {
    setState(() {
      _notificationCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showDemoNotification(String orderStatus) {
    // Show a demo notification related to the order status
    String message;
    if (orderStatus == 'Pending') {
      message = 'Someone has placed a new order!';
    } else if (orderStatus == 'Delivered') {
      message = 'Order has been delivered!';
    } else {
      message = 'Order status updated!';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Homepage'),
        backgroundColor: const Color(0xFF3EA120), // Green AppBar
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Show demo notification when notifications are clicked
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('You have a new notification!')),
                  );
                },
              ),
              if (_notificationCount > 0) // Badge for notifications
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Text(
                'Welcome, ${widget.dealer.name}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Notification Section
              _buildNotificationSection(),
              const SizedBox(height: 20),

              // Order View Section
              const SectionHeader(title: 'Recent Orders'),
              _buildOrderCard('Order #123', 'Pending', Icons.access_time),
              _buildOrderCard('Order #124', 'Delivered', Icons.check_circle),
              const SizedBox(height: 20),

              // Location Update Section
              const SectionHeader(
                  title: 'Update Location', icon: Icons.location_on),
              _buildLocationUpdateSection(),

              const SizedBox(height: 20),

              // Profile Edit Section
              const SectionHeader(title: 'Edit Profile', icon: Icons.edit),
              _buildProfileEditSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Notification Section
  Widget _buildNotificationSection() {
    return Card(
      color: const Color(0xFFEAF7E4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading:
            const Icon(Icons.notifications_active, color: Color(0xFF3EA120)),
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('You have $_notificationCount unread notifications.'),
        trailing: IconButton(
          icon: const Icon(Icons.add_alert, color: Color(0xFF3EA120)),
          onPressed: () {
            _incrementNotification('New notification added.');
          },
        ),
      ),
    );
  }

  // Helper function to build Order Card
  Widget _buildOrderCard(String order, String status, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xFFEAF7E4),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF3EA120)),
        title: Text(order, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Status: $status'),
        trailing: ElevatedButton(
          onPressed: () {
            _showDemoNotification(
                status); // Show notification based on order status
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3EA120),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('View'),
        ),
      ),
    );
  }

  // Location Update Section
  Widget _buildLocationUpdateSection() {
    return Card(
      color: const Color(0xFFEAF7E4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'New Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3EA120),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _incrementNotification('Location updated successfully.');
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  // Profile Edit Section
  Widget _buildProfileEditSection() {
    return Card(
      color: const Color(0xFFEAF7E4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3EA120),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _incrementNotification('Profile updated successfully.');
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

// Section Header Widget
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;

  const SectionHeader({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: const Color(0xFF3EA120)),
          const SizedBox(width: 10),
        ],
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
