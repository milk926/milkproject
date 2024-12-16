import 'package:flutter/material.dart';

class AddToCartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartProducts;

  AddToCartPage({super.key, required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    // Demo products to display when cart is empty
    final List<Map<String, dynamic>> demoProducts = [
      {
        'name': 'milk',
        'price': 26,
        'description': 'This is a sample description for Demo Product 1.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSAyH854FlWZlrM6qQL95q_2xSbyYjkUzP-w&s',
      },
      {
        'name': 'cheese',
        'price': 24,
        'description': 'This is a sample description for Demo Product 2.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0TMriLN-YT6t2VZvr8tFMXSWPf4sFS8sH6Q&s',
      },
      {
        'name': 'butter',
        'price': 22,
        'description': 'This is a sample description for Demo Product 3.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0TMriLN-YT6t2VZvr8tFMXSWPf4sFS8sH6Q&s',
      },
      {
        'name': 'yogurt',
        'price': 30,
        'description': 'This is a sample description for Demo Product 4.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7ua1fAq4_iTDCcNw1r8VLTW-i5GAnmKYcTA&s',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3EA120),
        foregroundColor: Colors.white,
      ),
      body: cartProducts.isEmpty
          ? ListView.builder(
              itemCount: demoProducts.length,
              itemBuilder: (context, index) {
                final product = demoProducts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        product['image'],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            height: 150,
                            child: Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 60,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product['description'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Price: ₹${product['price']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Implement Order Now action here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Order placed for ${product['name']}!'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3EA120),
                              ),
                              child: const Text(
                                'Order Now',
                                style: TextStyle(
                                  color:
                                      Colors.white, // Text color is now white
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                final product = cartProducts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      product['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 60,
                          color: Colors.grey,
                        );
                      },
                    ),
                    title: Text(product['name']),
                    subtitle: Text('₹${product['price']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Remove product from the cart
                        cartProducts.removeAt(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${product['name']} removed from cart!'),
                          ),
                        );
                        // Refresh the UI by updating the page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddToCartPage(cartProducts: cartProducts),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      // Show product details on tap
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(product['name']),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  product['image'],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 10),
                                Text('Price: ₹${product['price']}'),
                                const SizedBox(height: 10),
                                Text('Product Details: ${product['name']}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}