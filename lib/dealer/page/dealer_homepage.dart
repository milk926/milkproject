import 'package:flutter/material.dart';
import 'package:milkproject/dealer/DealerAccountPage.dart';
import 'package:milkproject/dealer/dealerUpdateLocation.dart';
import 'package:milkproject/dealer/dealer_notification.dart';
import 'package:milkproject/dealer/page/dealer_editProfile.dart';
import 'package:milkproject/dealer/viewOrder.dart';
import 'package:milkproject/dealer/viewUser_Farmer.dart';
import 'package:milkproject/login_page.dart';

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

class DealerHome extends StatefulWidget {
  const DealerHome({super.key});

  @override
  State<DealerHome> createState() => _DealerHomeState();
}

class _DealerHomeState extends State<DealerHome> {
  final String dealerName = "John Doe";
  int _selectedIndex = 0;

  void _onBottomNavigationBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DealerHomePage()),
        );
        break;
      case 1: // Notifications
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const DealerNotificationScreen()),
        );
        break;
      case 2: // Profile
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DealerAccountPage(
              dealerEmail: '',
              dealerName: '',
              dealerPhone: '',
              dealerLocation: '',
            ),
          ),
        );
        break;
    }
  }

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
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
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
      drawer: Drawer(
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
                'asset/dealer_milksociety_img.jpeg',
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.1),
              child: Text(
                'Welcome, $dealerName',
                style: const TextStyle(
                  fontSize: 20,
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
        currentIndex: _selectedIndex,
        onTap: _onBottomNavigationBarTap,
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
                    builder: (context) => UpdateLocationPage()),
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LogIn()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}
