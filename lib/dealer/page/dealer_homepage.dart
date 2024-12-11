import 'package:flutter/material.dart';
import 'package:milkproject/dealer/DealerAccountPage.dart';
import 'package:milkproject/dealer/dealerUpdateLocation.dart';
import 'package:milkproject/dealer/dealer_notification.dart';
import 'package:milkproject/dealer/page/dealer_editProfile.dart';
import 'package:milkproject/dealer/viewOrder.dart';
import 'package:milkproject/dealer/viewUser_Farmer.dart';
import 'package:milkproject/user/page/login_page.dart';

class DealerHomePage extends StatelessWidget {
  const DealerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DealerHome(),
    );
  }
}

class DealerHome extends StatelessWidget {
  final String dealerName = "John Doe";

  const DealerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Dashboard'),
        backgroundColor: Colors.green.shade800,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit), // Changed to edit profile icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DealerEditProfilePage()),
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade800,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('My Account'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DealerAccountPage(
                              dealerEmail: '',
                              dealerName: '',
                              dealerPhone: '',
                              dealerLocation: '',
                            )));
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DealerNotificationScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DealerEditProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                _showSignOutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.green.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'asset/milkzone_dealer.jpeg',
                width: double.infinity,
                fit: BoxFit.none,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome, $dealerName',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildCard('Order', Icons.shopping_cart, context),
                    _buildCard('View User/Farmer', Icons.people, context),
                    _buildCard('Update Location', Icons.location_on, context),
                    _buildCard('Notifications', Icons.notifications, context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Navigator logic for each card
          switch (title) {
            case 'Order':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ViewOrderDetailsPage()),
              );
              break;
            case 'View User/Farmer':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ViewUserFarmerPage()),
              );
              break;
            case 'Update Location':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpdateLocationPage()),
              );
              break;
            case 'Notifications':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DealerNotificationScreen()),
              );
              break;
            default:
              break;
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.green.shade800,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Do you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog first
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
