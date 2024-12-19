import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:milkproject/society/page/ordermanagement.dart';
import 'package:milkproject/society/page/product_upload.dart';
import 'package:milkproject/society/page/profilepage.dart';
import 'package:milkproject/society/page/userAccount.dart';
import 'package:milkproject/society/page/viewfeedback.dart';

class MilkProjectHomePage extends StatelessWidget {
  const MilkProjectHomePage({super.key});

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()));
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
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF3EA120)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('User Accounts'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UserAccountPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Order Management'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderManagement()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Milk Product Upload'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UserProductUpload()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Cattle Feed Product Upload'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CattleFeedProductUpload()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => FeedbackViewPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotificationPage()));
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
        autoPlayInterval: const Duration(seconds: 5),
      ),
      items: imgList
          .map((item) => Container(
                margin: const EdgeInsets.all(5.0),
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
    return StreamBuilder<int>(
      stream: _getPendingOrdersStream(), // Stream for pending orders
      builder: (context, pendingOrdersSnapshot) {
        return StreamBuilder<double>(
          stream: _getTotalSalesStream(), // Stream for total sales
          builder: (context, totalSalesSnapshot) {
            return StreamBuilder<int>(
              stream: _getFeedbackCountStream(), // Stream for feedback count
              builder: (context, feedbackSnapshot) {
                if (pendingOrdersSnapshot.connectionState ==
                        ConnectionState.waiting ||
                    totalSalesSnapshot.connectionState ==
                        ConnectionState.waiting ||
                    feedbackSnapshot.connectionState ==
                        ConnectionState.waiting) {
                  // Return loading indicators if any stream is waiting
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard('Total Sales', '...', Icons.attach_money,
                          Colors.green),
                      _buildStatCard('Pending Orders', '...',
                          Icons.shopping_cart, Colors.blue),
                      _buildStatCard(
                          'Feedback', '...', Icons.feedback, Colors.orange),
                    ],
                  );
                } else if (pendingOrdersSnapshot.hasError ||
                    totalSalesSnapshot.hasError ||
                    feedbackSnapshot.hasError) {
                  return Text(
                      'Error: ${pendingOrdersSnapshot.error ?? totalSalesSnapshot.error ?? feedbackSnapshot.error}');
                } else {
                  final pendingOrders = pendingOrdersSnapshot.data ?? 0;
                  final totalSales = totalSalesSnapshot.data ?? 0.0;
                  final totalFeedback = feedbackSnapshot.data ?? 0;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard(
                          'Total Sales',
                          '₹${totalSales.toStringAsFixed(2)}',
                          Icons.attach_money,
                          Colors.green),
                      _buildStatCard('Pending Orders', '$pendingOrders',
                          Icons.shopping_cart, Colors.blue),
                      _buildStatCard(
                          'Feedback',
                          '$totalFeedback', // Display actual feedback count
                          Icons.feedback,
                          Colors.orange),
                    ],
                  );
                }
              },
            );
          },
        );
      },
    );
  }

// Stream for getting the total sales
  Stream<double> _getTotalSalesStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.fold<double>(
          0.0,
          (sum, doc) =>
              sum +
              (doc['totalPrice'] is num ? doc['totalPrice'].toDouble() : 0));
    });
  }

// Stream for getting the number of pending orders
  Stream<int> _getPendingOrdersStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: 'Pending')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.length);
  }

// Stream for getting the number of feedbacks
  Stream<int> _getFeedbackCountStream() {
    return FirebaseFirestore.instance
        .collection('feedback') // Listen to 'feedback' collection
        .snapshots() // Listen for real-time updates
        .map((querySnapshot) =>
            querySnapshot.docs.length); // Count number of documents (feedbacks)
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
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
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
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildFeatureCard(context, 'User Accounts', Icons.people,
                'https://c8.alamy.com/comp/2CBA14N/milk-bottle-production-process-vector-illustration-cartoon-flat-infographic-poster-with-processing-line-in-automated-dairy-factory-making-pasteurization-and-bottling-milk-product-isolated-on-white-2CBA14N.jpg',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UserAccountPage()));
            }),
            _buildFeatureCard(context, 'Order Management', Icons.shopping_cart,
                'data:image/png;base64,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',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderManagement()));
            }),
            _buildFeatureCard(context, 'Feedback', Icons.feedback,
                'data:image/png;base64,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',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => FeedbackViewPage()));
            }),
            _buildFeatureCard(context, 'Notifications', Icons.notifications,
                'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw8NDg0NDQ8NDg8PDw8PEA8QDg8PEA4PFREWFhUWFRUYHSgsGholGxUVITEhJSkrLjA6Fx81ODMsNygtLisBCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIAOEA4QMBIgACEQEDEQH/xAAcAAEAAQUBAQAAAAAAAAAAAAAAAQIDBQYHBAj/xABHEAACAgEBBAcEBAoIBgMAAAAAAQIDBBEFBhIhBxMxQVFhcRQigZEyUqHBIyRCYnJzgpKisRUzQ2NkssLRU5OjtNLhCCUm/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AO4gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMLvLvRibLgp5VnvyTddMEpXW6fVj4eb0Xmcv2z0sZtraw66sWHdKSV1vrz91emj9QO1A+b8rfDaVv8AWZ2Tz7oz6pfKGiPH/TGQ3q7Zy/SfE/mwPpwHzjh7y5NTXBfdX+hbOK+WvM2vY3STm1NK7gyod/ElXYl5SitPmmB2MGC3e3sxNoaRqk67dOdNmkZ+fD3SXp8dDOgAAAAAAAAAAAAAAAAAAAAAAAAAAANW3+3uhsmhcCjPKtTVNb7Fp22T0/JXh3vl4tbHm5UKKrL7ZKNdUJWTk/yYxWrfyRwjCx7949qWXWcUK21Kb7eox0/crj3cXd6uUvEDy7G2DnbbvsvnOT4pfhsq3mk/qxXe0uyK0S5di0OlbH3B2fjJcdXtM++d+klr5Q7NPVN+ZsWFiV49cKaYRrrguGMV2Jfe+9vvL4FirBpgtIU0xXhGuEV8kjzZmwcO9aXYuPPzdUFL4SS1RkQBoO2ujHHsTlhWSx591c27Kn8XzXrq/Q55tbZGVs6zq8mtw1+jJe9XZ5xku307fFH0CWM/Bqya5U31xtrl2xktV5NeD81zA4ThZSbjz4ZJppp6NNdjT7mdO3S32kuGjPlquShkPtXlZ4r875+JpW+W5lmzm76OK3Fb+k+c6G+xT8V4S+D88Lh7RaShN8uxPw8mB9IJ6pNc0+afiScs3F306iccPKl+Bk9K7JP+pk+yLf1H9np2dTAAAAAAAAAAAAAAAAAAAAAAAAA590zbWdODViweksuz3ufPqa9JS/ida9Gz0bgbFWFgVcS0tvSvt8U5L3Y/COnLxcvE1rpAj7fvBh4L0lCuNMJx8pN22/OvT5HSgAAAkAx9W28SeRLEjkVPIi2nVxe9qu1LubXelzQGRAAFNtcZxlCaUoyTjKMkmpRfJprvRxvfrdR7Pt62pOWJa9IdrdM+3q5Pw7dH961fZzzbRwa8qmzHujxV2R4ZL+TXg09Gn5AfPHWNcnz8/FHXeire72mH9H5Etbqo60zb521L8nzlH7V6M5lvBsezByLMaznKD1hLsVlb+jL0a5eTT8DHYmZPGtqvpk4WVTjZXLwkn3rw7mvVAfUQMXuztqvaOHRl18usj78e+uyL0nF+jT9eT7zKAAAAAAAAAAAAAAAAAAAAAAHJtmLrt6s+b59XGyS8uCuqj/UdENA3Wj/+h2y32pXr4O+v/ZG/gSJSSTbaSSbbb0SS7W2DVukvOdGzbIxejyJwx9fzZaymvjGEl8QMHtnpOUZyhg0xsjHkrrXJRm/GMFo9PNtehzlZNit69Sat6zrVPvVnFxcXz5lokD6C2LtanOohfROMk0uNJ8656auMl3NGQ0OH7qZ88GvOzq5NSjXXj1w/IndbJuMpLv4Y12S0PRsDZe1NoznkV33wcU5rJttuhGc0/oxku3v7FotAO0A0ro93ulnJ42S08iEOOE9EuvrXbql+WuWunb29zN1A1DpK2F7Vi+0VrW7FTny7Z0/lx+H0l6PxOKZ64ea7H9j7/n2/Bn001ryfNeZwXfTYnsuVk4qWkdesp/Vy5w+XOPwYGa6E95OpzLNnWS/B5ac6tX2ZEI80v0oJ/wDLXidxPj/EzbMe2rIpfDbTZC2tvXlOElJa+Wq5n1psfaMMzGx8ur+rvqrtj4pTino/PmB7AAAAAAAAAAAAAAAAAAAAAHLtjrq96NqV90qZy+MvZrF9kmb6aRtyPs29GJZ2RyqFGT8ZcFkEvnCv5o3cAaH0vP8AFcRf4lv5VSX3m+Gh9Ly/FcR/4hr/AKcv9gOWEkgDKYq48DLgu2vIxL2vzOG6pv4Sth8zcOjPbN9jnhylHqKMS6cIqKT4nbF6uXa/pS+ZpOyMyNFutkXOmyEqb4LRSlTP6XD+cmlJecUZzYuX/Qt9llkHkU5OPOum+p6Qti2mpR17/d0cG04/zDC7s5csfLwro8nG6rXzg2ozXxi2vifQBwvczZE8zMx4RTcKp123S092FcWno34vTRevkzuoA5/0tbO4q8bMiucJOmb8Yy96Dfo01+2dAMRvdhe0bPzKtNZdVKcF4zh78ftigPmfalXBdNd0veXx7ft1O79BG1XfsueNJ6yw8ida56vqrErIv5ymv2Tiu36+Vc/WP3r7zef/AI/5/BtDMxm+V+KrF+lTYl/K1/IDvIAAAAAAAAAAAAAAAAAAAADnfS9U6ls7aME3LFydGl3p6WR18tatP2jbq7IzjGcXrGSUovxi1qn8ijfDZXt2z8rGS1nKtyr/AFsHxw/iil8TXOjjaftOzqYt6zx28eXb2RSdf8DitfJgbQaF0u2r2fDr1953zml5Rraf+dG6bSyXRj33xg7HVVZYq09HNxi3wp+ehw/b227toXdfe1yXDCEdVCuHhFfzb7fkBjNCSRoBBs+4GVP26jEk+PGvlZ1tE4xnVNqmck+GSej1iua58jWTYuj5f/a4Xrd/29gHZsbGrpjwU111R7eGuEYR19EXiCQAa15PsfJ+gAHzZvJi9XG+v/g2uP7s3A9fRFkOrbuz9OSs9oql5xePZJL96Mfkevfqrhytpx/vrpfOTkYro45bZ2W/8QvthJfeB9RAAAAAAAAAAAAAAAAAAAAABzHHj/RG3rsd+7jbRSnX3RjY3JxX7/WQ0X14HTjUekrYLzcPraU/aMRu6px5ScV9OKfjolJecEBmzU9u7hYeVxTqTxbXq+KtJ1t/nV/+LRkd0NuLaGJXc2utj+DuS5aWpLVpeElpJeuncZsDie3N0M3C1lOvral/a06zil+cu2PxWnmYFH0RbFyjKKk4OUZJSXbFtaarzRxvPyanbZj7VxuC+uThLKxVGqxv606uUbE+T1XC9GBrZmtzMlU7SwrJPRdbwN/rIyrX+cu5G6l/UxysT8dxpcXDZVCSsXC2nxVPmmmmuWvYYL7Gn6NNAfRRJr+5m8C2hjJya9oqUYXx729OU0vCWjfrqu42AAASgODb9y1zNpv+8uXy5GN6M6uLbezI/wB9OX7tFk/9Jc3kyOtnmW9qtutkvSdr0+xmZ6FcDrNrK3Tlj49tmvhKWla+ycgO+gAAAAAAAAAAAAAAAAEANSlyDKGwK+McZZbLU5gc52tU939p+1VxfsGa9LYxWvVy1baSXfFtyivByS7NTfqrYzjGcJKUZJSjKL1Uotapp+Gh4du015VFmNkR4q7FpqvpQkvoyi/FPmaNuxt2eyb3s3Pl+Ltt03vlGvV8n5Vvnr9V692rQdKMbtfd/EzuF5NMZyitFNOUJpeHFFpteRkUyQLeJjQprhVVFQrglGMY9kUY3be7OHnau+pKx/21fuWr4/lftJmXAGn7s7lz2dmPIjkqdPVzhwcDjOSlpopc9NE0nr5dhuRBIAxm8+f7LhZV+uko1SUP1kvdh/E0ZM5t0p7ZUpVYFb14GrbtPrNe5F/BuXxiBzXaH0YwXe/sS/30Os9COyeqxcnMktHkWKuD8aqtea/blNfsnMsDZtmbk10UrWc5KuPgu+Un5Lm3+ifReysCGJj041S0hTCMI+L0XNvzb1b9QPYCCQAAAAAAAAAAAAAAAAKGUSLjLcgLUzy2yZ65IszgBispNpo0/efZHtEOF83HVwlp70H5eK8jfLajwZGKn3Ac73W3wt2bJYecpzx48oSXOdC8vrQ8u1d3gdSw8uu+uNtM4WVyWsZweqf/AL8jTNu7uV5EWpR590lyaNLVW0Nj2SsxpzUG9ZaLihNL/iQf8/tQHbgc62R0oVySjm0ShLvso9+D83CT1ivRyNkxt9tmWrVZdcfKyNlLX78UBsRJr2RvrsytavLrl5Vxsuf8CZrO2ukvVOGBS0+zrr0uXnGtPn6ya9GBtO9u8tezqu6eRNPqav8AXLwivt7Djc5WX2SlJysttk5Sk+blKT5v5vsPXg4WXtO+XArMi2bTssk+UfOcuyK8F8Eu46pulufTgaWzauyPrte7W/zF97+wCno+3TWBD2i+P4xZHRRf9jW+en6T5a/Lx13NFqLK0wK0SUoqAkEEgAAAAAAAAAAAIJIAhlDK2UsChoocS60UtAWJQLE6j2NFLiBi7cfUx2XgKSeqNhlWWJ0gc12zufVY3KC6uXjHkn6o1TL3duqfPmvHQ7Vdia9xjsjZyfdqByvZu77ukoyujVr3uty+9G57K6P8WOkrrbMjyX4KD9Um39pkZbATesVo/DuMrg1zq0jLX1AyGBiVUQVdNcK4LsjCKitfH18z3QZZpep6IxArTK0yhIrQFaKkUIrQEkkEgAAAAAAAAAAAAAEEEgCkpaKyAKGilouaEaAWmilxLzRS0BYlAtyqPU0UuIHk6klVHp4RwgW64F6KIUS5EAkVJBIqSAJEoaEgCQAAAAAAAAAAAAAAAQSAIIJAEEaFRAFOhGhXoRoBRoRoXNCNAKNBoV6DQCjQlIq0J0AIqIRIAkAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAAgAASAAJJAAAAAAAAAAAAD/2Q==',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotificationPage()));
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
            Image.network(imagePath,
                height: 50, width: 50, fit: BoxFit.contain),
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
          label: 'Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: const Color(0xFF3EA120),
      onTap: (index) {
        // Handle navigation based on index
        switch (index) {
          case 0:
            // Already on Home
            break;
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => UserProductUpload()));
            break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
            break;
        }
      },
    );
  }
}

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('orders')
              .where('status', isEqualTo: 'Pending')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No pending orders.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            final notifications = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'name': data['productName'] ?? 'Unknown Product',
                'quantity': data['quantity'] ?? 0,
                'timestamp': data['timestamp'] ?? '',
                'address': data['address'] ?? 'No Address',
              };
            }).toList();

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(
                  name: notification['name'] ?? '',
                  quantity: notification['quantity'] ?? 0,
                  timestamp: notification['timestamp'] ?? '',
                  address: notification['address'] ?? '',
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Notification card widget
  Widget _buildNotificationCard({
    required String name,
    required int quantity,
    required dynamic timestamp,
    required String address,
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
                    'New Order: $name',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Quantity: $quantity',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Address: $address',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Time: ${_formatTimestamp(timestamp)}',
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

  // Helper method to format the timestamp (if it's a Timestamp object)
  String _formatTimestamp(dynamic timestamp) {
    try {
      // Check if the timestamp is of type Timestamp and convert it to DateTime
      DateTime parsedTimestamp;
      if (timestamp is Timestamp) {
        parsedTimestamp = timestamp.toDate(); // Convert Timestamp to DateTime
      } else if (timestamp is String) {
        parsedTimestamp =
            DateTime.parse(timestamp); // If it's a string, parse it
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
