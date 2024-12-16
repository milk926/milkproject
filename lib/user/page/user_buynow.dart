import 'package:flutter/material.dart';
import 'package:milkproject/user/page/addtocart.dart';
import 'package:milkproject/user/page/buy_now.dart';
import 'package:milkproject/user/page/userprofile.dart';

class MilkProductPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Milk',
      'price': 26,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSAyH854FlWZlrM6qQL95q_2xSbyYjkUzP-w&s',
      'description': 'Fresh and organic cow milk.',
    },
    {
      'name': 'Cheese',
      'price': 24,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0TMriLN-YT6t2VZvr8tFMXSWPf4sFS8sH6Q&s',
      'description': 'Rich and creamy natural cheese.',
    },
    {
      'name': 'Butter',
      'price': 22,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7ua1fAq4_iTDCcNw1r8VLTW-i5GAnmKYcTA&s',
      'description': 'Pure butter made from fresh cream.',
    },
    {
      'name': 'Yogurt',
      'price': 30,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0TMriLN-YT6t2VZvr8tFMXSWPf4sFS8sH6Q&s',
      'description': 'Healthy and delicious yogurt.',
    },
  ];

   MilkProductPage({super.key, required List cartProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.store, size: 50, color: Colors.green),
                  SizedBox(height: 10),
                  Text(
                    'Milk Zone',
                    style: TextStyle(color: Colors.green, fontSize: 20),
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
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddToCartPage(cartProducts: []);
                }));
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 40),
            Text(
              'Milk Zone',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF3EA120),
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
      body: ListView.builder(
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
                          product['name'],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '₹${product['price']}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product['image'],
                      height: 120,
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
                    product['description'],
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
                          backgroundColor: const Color(0xFF3EA120),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const AddToCartPage(
                                cartProducts: [],
                              );
                            },
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${product['name']} added to cart!'),
                            ),
                          );
                        },
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                              color: Colors.white), // White text color
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3EA120),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const BuyNowPage();
                            },
                          ));
                        },
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(
                              color: Colors.white), // White text color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
