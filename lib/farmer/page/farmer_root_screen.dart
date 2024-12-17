import 'package:flutter/material.dart';
import 'package:milkproject/farmer/page/farmer_profile_page.dart';

class FarmerBottomNavScreen extends StatefulWidget {
  const FarmerBottomNavScreen({super.key});

  @override
  _FarmerBottomNavScreenState createState() => _FarmerBottomNavScreenState();
}

class _FarmerBottomNavScreenState extends State<FarmerBottomNavScreen> {
  int _selectedIndex = 0; // Current index for the bottom navigation

  // List of screens for each section
  final List<Widget> _screens = [
    const FarmerProfileScreen(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
  ];

  // Handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Milk Production App'),
      ),
      body: _screens[_selectedIndex], // Display content based on selected tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green, // Selected item color (green)
        unselectedItemColor: Colors.black, // Unselected items color (black)
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'asset/manure.png',
              width: 30,
              height: 30,
              color: Colors.black,
            ),
            label: ' Dung',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Milk ',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Buy Products',
          ),
        ],
      ),
    );
  }
}
