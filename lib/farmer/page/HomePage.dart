import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:milkproject/login_page.dart';
import 'package:milkproject/user/page/buy_now.dart';
import 'profile.dart';
import 'cart.dart';
import 'orders.dart';
import 'supplies.dart';

class FarmerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milk Zone',
      color: Colors.white,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: FarmerHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FarmerHomePage extends StatelessWidget {
  final List<String> carouselImages = [
    "https://via.placeholder.com/600x300.png?text=Welcome+to+Milk+Zone",
    "https://via.placeholder.com/600x300.png?text=Quality+Products",
    "https://via.placeholder.com/600x300.png?text=Farm+Fresh+Feed",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[800]!, Colors.green[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          "Milk Zone",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, size: 28),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FarmerProfilePage()),
              );
            },
          ),
        ],
        elevation: 5,
      ),
      drawer: FarmerMenuDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: 180,
                  viewportFraction: 0.9,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                ),
                items: carouselImages.map((url) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // Welcome Section
              Text(
                "👋 Welcome Back, Farmer!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 16),

              // Info Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child:
                        InfoCard(title: "Today's Supply", value: "25 Liters"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InfoCard(title: "Payment Received", value: "₹1,200"),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Cattle Feed Products
              Text(
                "🐄 Cattle Feed Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 12),
              ProductList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FarmerBottomNavigationBar(),
    );
  }
}

// Bottom Navigation Bar
class FarmerBottomNavigationBar extends StatefulWidget {
  @override
  _FarmerBottomNavigationBarState createState() =>
      _FarmerBottomNavigationBarState();
}

class _FarmerBottomNavigationBarState extends State<FarmerBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FarmerHomePage(),
    CartPage(),
    FarmerProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green[800],
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _pages[index]),
        );
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}

// Product List
class ProductList extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      "name": "Premium Feed 50kg",
      "description": "Boost milk yield with premium quality feed.",
      "price": "₹1,500",
      "image": "https://via.placeholder.com/400x200"
    },
    {
      "name": "Basic Cattle Feed",
      "description": "Affordable and healthy feed for your cattle.",
      "price": "₹900",
      "image": "https://via.placeholder.com/400x200"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products.map((product) {
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(product['image']!, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name']!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),
                    Text(
                      product['description']!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Price: ${product['price']}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                          fontSize: 16),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800],
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("${product['name']} added to cart!"),
                              ),
                            );
                          },
                          icon: Icon(Icons.add_shopping_cart),
                          label: Text("Add to Cart"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[700],
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BuyNowPage(
                                  productName: 'milk',
                                ),
                              ),
                            );
                          },
                          child: Text("Buy Now"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Info Card Widget
class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }
}

// Drawer Menu Widget
class FarmerMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[800]!, Colors.green[400]!],
              ),
            ),
            padding: EdgeInsets.only(top: 60, bottom: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.green[800]),
                ),
                SizedBox(height: 10),
                Text(
                  "Farmer Name",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.shelves),
            title: Text("Supplies"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuppliesHistoryPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("My Orders"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyOrdersPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FarmerProfilePage()),
              );
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
