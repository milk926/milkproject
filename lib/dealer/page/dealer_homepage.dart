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
      home: const DealerLoginPage(),
    );
  }
}

class DealerLoginPage extends StatelessWidget {
  const DealerLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulating a dealer login
    // Here you could replace with actual login logic and get dealer's name from input
    Dealer dealer = Dealer('John Doe');  // Example dealer name

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to DealersHomepage and pass dealer object
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DealersHomepage(dealer: dealer)),
            );
          },
          child: const Text('Go to Homepage'),
        ),
      ),
    );
  }
}

class DealersHomepage extends StatelessWidget {
  final Dealer dealer;

  const DealersHomepage({super.key, required this.dealer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Homepage'),
        backgroundColor: const Color(0xFF3EA120), // Green AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to Notifications page
            },
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
                'Welcome, ${dealer.name}', // Use the dealer's name here
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Heading color is now black
                ),
              ),
              const SizedBox(height: 20),

              // Order View Section
              const SectionHeader(title: 'Recent Orders'),
              _buildOrderCard('Order #123', 'Pending', Icons.access_time),
              _buildOrderCard('Order #124', 'Delivered', Icons.check_circle),
              const SizedBox(height: 20),

              // Location Update Section
              const SectionHeader(title: 'Update Location', icon: Icons.location_on),
              Card(
                color: const Color(0xFFEAF7E4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                          // Update location action
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Profile Edit Section
              const SectionHeader(title: 'Edit Profile', icon: Icons.edit),
              Card(
                color: const Color(0xFFEAF7E4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                          // Save profile changes
                        },
                        child: const Text('Save Changes'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Customer/Farmer Details Section
              const SectionHeader(title: 'Customer/Farmer Details', icon: Icons.people),
              Card(
                color: const Color(0xFFEAF7E4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Contact')),
                    DataColumn(label: Text('Activity')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Farmer A')),
                      DataCell(Text('123-456-7890')),
                      DataCell(Text('Order #123')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Farmer B')),
                      DataCell(Text('987-654-3210')),
                      DataCell(Text('Order #124')),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Notifications Section
              const SectionHeader(title: 'Notifications', icon: Icons.notifications_active),
              _buildNotificationCard('New Order from Farmer B', 'Order #125'),
              _buildNotificationCard('Order #123 delivered successfully', 'Thank you for your service.'),
            ],
          ),
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
            // Navigate to Order Details
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

  // Helper function to build Notification Card
  Widget _buildNotificationCard(String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xFFEAF7E4),
      child: ListTile(
        leading: const Icon(Icons.notifications_active, color: Color(0xFF3EA120)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;

  const SectionHeader({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: const Color(0xFF3EA120)),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Heading color is now black
            ),
          ),
        ],
      ),
    );
  }
}
