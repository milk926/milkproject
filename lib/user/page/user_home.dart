import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milkproject/farmer/page/orders.dart';
import 'package:milkproject/login_page.dart';
import 'package:milkproject/user/page/addtocart.dart';
import 'package:milkproject/user/page/buy_now.dart';
import 'package:milkproject/user/page/feedback.dart';
import 'package:milkproject/user/page/userprofile.dart';
import 'package:carousel_slider/carousel_slider.dart';

final currentUser = FirebaseAuth.instance.currentUser;

class MilkProductPage extends StatelessWidget {
  const MilkProductPage({super.key, required List cartProducts});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.store, size: 50, color: Colors.blue),
                  SizedBox(height: 10),
                  Text(
                    'Milk Zone',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProfileScreen();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.online_prediction_rounded),
              title: const Text('My Orders'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyOrdersPage();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddToCartPage(); // Existing cart
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Feedback'),
              onTap: () async {
                // Retrieve the current user's username
                String? userName;

                try {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null) {
                    // Assuming the user's name is stored in the Firestore users collection
                    final userDoc = await FirebaseFirestore.instance
                        .collection('user')
                        .doc(currentUser.uid)
                        .get();

                    userName = userDoc.data()?['name'] ??
                        currentUser.displayName ??
                        "Guest";
                  } else {
                    userName = "Guest";
                  }
                } catch (e) {
                  userName = "Guest"; // Fallback if there's an error
                }

                // Navigate to the FeedbackPage with the username
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FeedbackPage(userName: userName ?? "Guest");
                }));
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Milk Zone',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 8, 111, 255),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ProfileScreen();
              }));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Carousel Slider
          _buildCarouselSlider(),
          SizedBox(height: 16),

          // Welcome Section
          Text(
            "👋 Welcome Back, User!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 16),

          // Milk Products List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products available',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  );
                }

                final products = snapshot.data!.docs.map((doc) {
                  return doc.data() as Map<String, dynamic>;
                }).toList();

                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product['name'] ?? 'Unnamed Product',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '₹${product['price'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                product['image_url'] ?? '',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 100,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              product['description'] ??
                                  'No description available.',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 8, 111, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    try {
                                      // Query the cart collection to check if the product already exists for the current user
                                      final QuerySnapshot query =
                                          await firestore
                                              .collection('cart')
                                              .where('user_id',
                                                  isEqualTo: currentUser?.uid)
                                              .where('name',
                                                  isEqualTo: product['name'])
                                              .get();

                                      if (query.docs.isNotEmpty) {
                                        // Product already exists in the cart, update its quantity or any other field
                                        final cartItemDoc = query.docs.first;
                                        await firestore
                                            .collection('cart')
                                            .doc(cartItemDoc.id)
                                            .update({
                                          'quantity': FieldValue.increment(
                                              1), // Example: Increment the quantity
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '${product['name']} quantity updated in the cart!'),
                                          ),
                                        );
                                      } else {
                                        // Product does not exist in the cart, add it as a new item
                                        await firestore.collection('cart').add({
                                          'user_id': currentUser?.uid,
                                          'name': product['name'],
                                          'price': product['price'],
                                          'image': product['image_url'],
                                          'description': product['description'],
                                          'quantity':
                                              1, // Start with a quantity of 1
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '${product['name']} added to cart!'),
                                          ),
                                        );
                                      }
                                    } catch (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Failed to process ${product['name']}. Please try again.'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Add to Cart',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 8, 111, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return BuyNowPage(
                                          productName: product['name'],
                                          productPrice: product['price'],
                                          productImageUrl: product['image_url'],
                                        );
                                      },
                                    ));
                                  },
                                  child: const Text(
                                    'Buy Now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Carousel Slider Method
  Widget _buildCarouselSlider() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('announcements')
          .doc('main')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching announcements'));
        }

        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return const Center(child: Text('No announcements available'));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final List<String> imgList = (data['image_urls'] as List<dynamic>?)
                ?.map((item) => item.toString())
                .toList() ??
            [];

        if (imgList.isEmpty) {
          return const Center(child: Text('No announcements available'));
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
          ),
          items: imgList.map((imgUrl) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imgUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
