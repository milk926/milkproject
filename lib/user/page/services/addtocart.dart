import 'package:flutter/material.dart';

class AddToCartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartProducts;

  const AddToCartPage({super.key, required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    // Demo products to display when cart is empty
    final List<Map<String, dynamic>> demoProducts = [
      {
        'name': 'milk',
        'price': 26,
        'description': 'This is a sample description for Demo Product 1.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSAyH854FlWZlrM6qQL95q_2xSbyYjkUzP-w&s', // Replace with an actual image URL
      },
      {
        'name': 'cheese',
        'price': 24,
        'description': 'This is a sample description for Demo Product 2.',
        'image':
            'image/jpeg;base64,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', // Replace with an actual image URL
      },
      {
        'name': 'butter',
        'price': 22,
        'description': 'This is a sample description for Demo Product 3.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0TMriLN-YT6t2VZvr8tFMXSWPf4sFS8sH6Q&s', // Replace with an actual image URL
      },
      {
        'name': 'yogurt',
        'price': 30,
        'description': 'This is a sample description for Demo Product 3.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7ua1fAq4_iTDCcNw1r8VLTW-i5GAnmKYcTA&s', // Replace with an actual image URL
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3EA120),
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
                              child: const Text('Order Now'),
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
