import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:milkproject/farmer/page/BuyNow.dart';
import 'package:milkproject/farmer/page/orders.dart';
import 'package:milkproject/user/page/addtocart.dart';
import 'profile.dart';

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

class FarmerHomePage extends StatefulWidget {
  @override
  _FarmerHomePageState createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  final List<String> carouselImages = [
    "https://via.placeholder.com/600x300.png?text=Welcome+to+Milk+Zone",
    "https://via.placeholder.com/600x300.png?text=Quality+Products",
    "https://via.placeholder.com/600x300.png?text=Farm+Fresh+Feed",
  ];

  int? totalQuantity;
  double? totalPayment;

  @override
  void initState() {
    super.initState();
    _fetchFarmerData();
  }

  Future<void> _fetchFarmerData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('farmerSales')
          .doc(userId)
          .get();

      if (doc.exists) {
        setState(() {
          totalQuantity = doc.data()?['totalQuantity'] ?? 0;
          totalPayment = doc.data()?['totalPayment']?.toDouble() ?? 0.0;
        });
      } else {
        setState(() {
          totalQuantity = 0;
          totalPayment = 0.0;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

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

              // Info Cards (Dynamic Data)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InfoCard(
                      title: "Today's Supply",
                      value: totalQuantity != null
                          ? "$totalQuantity Liters"
                          : "Loading...",
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InfoCard(
                      title: "Payment Received",
                      value: totalPayment != null
                          ? "₹${totalPayment?.toStringAsFixed(2)}"
                          : "Loading...",
                    ),
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

              // Fetch and display products from Firestore
              CattleFeedProductList(),
            ],
          ),
        ),
      ),
    );
  }
}

// Cattle Feed Product List Widget
class CattleFeedProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cattleFeedProduct')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final products = snapshot.data!.docs;

        return Column(
          children: products.map((product) {
            final productMap = product.data() as Map<String, dynamic>;

            return Card(
              margin: EdgeInsets.only(bottom: 16),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      productMap['image_url'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productMap['name'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        Text(
                          productMap['description'],
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Price: ₹${productMap['price']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                            fontSize: 16,
                          ),
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
                              onPressed: () async {
                                final user = FirebaseAuth.instance.currentUser;

                                if (user == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Please log in to add items to the cart.")),
                                  );
                                  return;
                                }

                                final cartProductData = {
                                  'name': productMap['name'],
                                  'description': productMap['description'],
                                  'price': productMap['price'],
                                  'image_url': productMap['image_url'],
                                  'quantity': 1,
                                  'user_id': user.uid,
                                };

                                try {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .add(cartProductData);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${cartProductData['name']} added to cart!"),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Failed to add to cart. Please try again.")),
                                  );
                                }
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
                                    builder: (context) => FarmerBuyNowPage(
                                      productName: productMap['name'],
                                      productPrice: productMap['price'],
                                      productImageUrl: productMap['image_url'],
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
      },
    );
  }
}

// Info Card Widget
class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// Drawer Widget (Menu)
class FarmerMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green[800],
            ),
            child: Text(
              'Milk Zone',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('My Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyOrdersPage()),
              );
            },
          ),
          ListTile(
            title: Text('Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddToCartPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FarmerProfilePage()),
              );
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
