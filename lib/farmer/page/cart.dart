import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cartItems = []; // List to store fetched cart items
  double totalPrice = 0.0; // Total price variable

  // Fetch the cart items from Firestore
  Future<void> fetchCartItems() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Query Firestore to get the cart items for the authenticated user
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('cart')
            .where('user_id', isEqualTo: user.uid)
            .get();

        setState(() {
          cartItems = snapshot.docs.map((doc) => doc.data()).toList();
          totalPrice = cartItems.fold(
              0.0,
              (sum, item) =>
                  sum + (item['price'] * item['quantity']).toDouble());
        });
      } catch (e) {
        print("Error fetching cart items: $e");
      }
    }
  }

  // Update quantity of cart item
  void updateQuantity(int index, int change) async {
    setState(() {
      cartItems[index]['quantity'] = cartItems[index]['quantity'] + change;
      totalPrice = cartItems.fold(
          0.0,
          (sum, item) =>
              sum + (item['price'] * item['quantity']).toDouble());
    });

    // Update the quantity in Firestore
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String docId = cartItems[index]['id']; // Assume you store the document ID
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(docId)
          .update({'quantity': cartItems[index]['quantity']});
    }
  }

  // Remove an item from the cart
  void removeItem(int index) async {
    setState(() {
      cartItems.removeAt(index);
      totalPrice = cartItems.fold(
          0.0,
          (sum, item) =>
              sum + (item['price'] * item['quantity']).toDouble());
    });

    // Remove the item from Firestore
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String docId = cartItems[index]['id']; // Assume you store the document ID
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(docId)
          .delete();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems(); // Fetch cart items when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[800]!, Colors.blue[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Imagse.file(
                              item['image_url'],
                              width: 100,
                              height: 150,
                              
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10),

                            // Product Title
                            Text(
                              item['productName'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),

                            // Product Description
                            Text(
                              item['description'],
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),

                            // Price and Quantity Controls
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${item['price'].toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[700],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove_circle,
                                          color: Colors.redAccent),
                                      onPressed: () =>
                                          updateQuantity(index, -1),
                                    ),
                                    Text(
                                      "${item['quantity']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_circle,
                                          color: Colors.blue),
                                      onPressed: () => updateQuantity(index, 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Remove Item Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: () => removeItem(index),
                                icon: Icon(Icons.delete, color: Colors.red),
                                label: Text("Remove",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 6,
                          spreadRadius: 1)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Total Price Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$${totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800]),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Checkout Button
                      ElevatedButton(
                        onPressed: () {
                          // Handle checkout logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          "Proceed to Checkout",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
