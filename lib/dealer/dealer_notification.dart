import 'package:flutter/material.dart';

// Model to represent a Notification
class DealerNotification {
  final String title;
  final String description;
  final IconData icon;

  DealerNotification({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class DealerNotificationScreen extends StatefulWidget {
  const DealerNotificationScreen({super.key});

  @override
  _DealerNotificationScreenState createState() =>
      _DealerNotificationScreenState();
}

class _DealerNotificationScreenState extends State<DealerNotificationScreen> {
  final List<DealerNotification> notifications = [
    DealerNotification(
      title: 'Order Placed',
      description: 'A user has placed an order for 5 liters of milk.',
      icon: Icons.shopping_cart,
    ),
    DealerNotification(
      title: 'Delivery Completed',
      description: 'A delivery of 3 liters has been completed.',
      icon: Icons.local_shipping,
    ),
  ];

  final TextEditingController notificationController = TextEditingController();
  IconData selectedIcon = Icons.notifications;

  // Function to add a new notification
  void _addNotification() {
    if (notificationController.text.isNotEmpty) {
      setState(() {
        notifications.add(
          DealerNotification(
            title: 'New Notification',
            description: notificationController.text,
            icon: selectedIcon,
          ),
        );
        notificationController.clear();
      });
    }
  }

  // Function to select an icon for the notification
  void _selectIcon(IconData icon) {
    setState(() {
      selectedIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Notifications'),
        backgroundColor: Colors.green, // Green app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Heading Section
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Your Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // Notification List
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(notification.icon, color: Colors.green),
                      title: Text(notification.title),
                      subtitle: Text(notification.description),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Add Notification Section
            const Text(
              'Add New Notification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: notificationController,
              decoration: InputDecoration(
                hintText: 'Enter notification message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 10),
            // Icon Selection for Notification
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => _selectIcon(Icons.shopping_cart),
                  color: selectedIcon == Icons.shopping_cart
                      ? Colors.green
                      : Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.local_shipping),
                  onPressed: () => _selectIcon(Icons.local_shipping),
                  color: selectedIcon == Icons.local_shipping
                      ? Colors.green
                      : Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () => _selectIcon(Icons.notifications),
                  color: selectedIcon == Icons.notifications
                      ? Colors.green
                      : Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Add Button
            ElevatedButton(
              onPressed: _addNotification,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Add Notification',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dealer Notification App',
      theme: ThemeData(
        primarySwatch: Colors.green, // Green theme for the app
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DealerNotificationScreen(),
    );
  }
}
