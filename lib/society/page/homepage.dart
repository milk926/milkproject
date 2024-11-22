import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MilkProjectHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Milk Project Dashboard'),
        backgroundColor: const Color(0xFF3EA120),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to Notifications Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotificationPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to Profile Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ProfilePage()));
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider for Announcements
              _buildCarouselSlider(),
              const SizedBox(height: 20),

              // Quick Stats Dashboard
              _buildQuickStats(),

              const SizedBox(height: 20),

              // Feature Sections
              _buildFeatureSections(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Side Navigation Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF3EA120)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Admin Name',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Admin Email',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: const Text('Sales Report'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SalesReportPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: const Text('User Accounts'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UserAccountsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: const Text('Order Management'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderManagementPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: const Text('Product Catalog'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ProductCatalogPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FeedbackPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotificationPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.check_circle),
            title: const Text('Order Status'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderStatusPage()));
            },
          ),
        ],
      ),
    );
  }

  // Carousel Slider Widget
  Widget _buildCarouselSlider() {
    final List<String> imgList = [
      'assets/images/announcement1.png',
      'assets/images/announcement2.png',
      'assets/images/announcement3.png',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: Duration(seconds: 5),
      ),
      items: imgList
          .map((item) => Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(item),
                    fit: BoxFit.cover,
                  ),
                ),
              ))
          .toList(),
    );
  }

  // Quick Stats Dashboard
  Widget _buildQuickStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
            'Total Sales', '₹12,000', Icons.attach_money, Colors.green),
        _buildStatCard('New Orders', '25', Icons.shopping_cart, Colors.blue),
        _buildStatCard('Feedback', '18', Icons.feedback, Colors.orange),
      ],
    );
  }

  // Individual Stat Card
  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 10),
              Text(
                value,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Feature Sections
  Widget _buildFeatureSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Features',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildFeatureCard(context, 'Sales Report', Icons.bar_chart,
                'assets/images/sales.png', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SalesReportPage()));
            }),
            _buildFeatureCard(context, 'User Accounts', Icons.people,
                'assets/images/users.png', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UserAccountsPage()));
            }),
            _buildFeatureCard(context, 'Order Management', Icons.shopping_cart,
                'assets/images/orders.png', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderManagementPage()));
            }),
            _buildFeatureCard(context, 'Product Catalog', Icons.inventory,
                'assets/images/catalog.png', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ProductCatalogPage()));
            }),
            _buildFeatureCard(context, 'Feedback', Icons.feedback,
                'assets/images/feedback.png', () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FeedbackPage()));
            }),
            _buildFeatureCard(context, 'Notifications', Icons.notifications,
                'assets/images/notifications.png', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotificationPage()));
            }),
            _buildFeatureCard(context, 'Order Status', Icons.check_circle,
                'assets/images/status.png', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderStatusPage()));
            }),
          ],
        ),
      ],
    );
  }

  // Individual Feature Card
  Widget _buildFeatureCard(BuildContext context, String title, IconData icon,
      String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 50, width: 50, fit: BoxFit.contain),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Color(0xFF3EA120),
      onTap: (index) {
        // Handle navigation based on index
        switch (index) {
          case 0:
            // Already on Home
            break;
          case 1:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SalesReportPage()));
            break;
          case 2:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ProfilePage()));
            break;
        }
      },
    );
  }
}

// Placeholder Pages
class SalesReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Report')),
      body: Center(child: const Text('Sales Report Page')),
    );
  }
}

class UserAccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Accounts')),
      body: Center(child: const Text('User Accounts Page')),
    );
  }
}

class OrderManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Management')),
      body: Center(child: const Text('Order Management Page')),
    );
  }
}

class ProductCatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Catalog')),
      body: Center(child: const Text('Product Catalog Page')),
    );
  }
}

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: Center(child: const Text('Feedback Page')),
    );
  }
}

class OrderStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Status')),
      body: Center(child: const Text('Order Status Page')),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(child: const Text('Profile Page')),
    );
  }
}

class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'New Order Placed',
      'description': 'A new order has been placed by User123.',
      'time': '2 mins ago',
    },
    {
      'title': 'Product Updated',
      'description': 'Milk price has been updated to \$2.50/L.',
      'time': '15 mins ago',
    },
    {
      'title': 'Order Dispatched',
      'description': 'Order #456 has been dispatched for delivery.',
      'time': '30 mins ago',
    },
    {
      'title': 'Feedback Received',
      'description': 'You received a 5-star feedback for your service.',
      'time': '1 hour ago',
    },
    {
      'title': 'Low Inventory Alert',
      'description': 'Stock for Yogurt is running low.',
      'time': '3 hours ago',
    },
    {
      'title': 'New User Registered',
      'description': 'A new user has signed up: User789.',
      'time': '1 day ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return _buildNotificationCard(
              title: notification['title'] ?? '',
              description: notification['description'] ?? '',
              time: notification['time'] ?? '',
            );
          },
        ),
      ),
    );
  }

  // Notification card widget
  Widget _buildNotificationCard({
    required String title,
    required String description,
    required String time,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification icon
            CircleAvatar(
              backgroundColor: const Color(0xFF3EA120).withOpacity(0.2),
              child: const Icon(Icons.notifications, color: Color(0xFF3EA120)),
            ),
            const SizedBox(width: 12),
            // Notification details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
