import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String? currentUserUid = auth.currentUser?.uid;

    if (currentUserUid == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
          centerTitle: true,
          backgroundColor: const Color(0xFF3EA120),
        ),
        body: const Center(
          child: Text(
            'You need to log in to view your cart.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3EA120),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('cart')
            .where('user_id', isEqualTo: currentUserUid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final cartProducts = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'name': data['name'],
              'id': doc.id,
              ...data,
            }; // Keep the id for future use
          }).toList();

          // Calculate total price
          double totalPrice = cartProducts.fold(
              0, (sum, product) => sum + (product['price'] as num));

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product['image'] ?? '',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'] ?? 'Unnamed Product',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Price: ₹${product['price'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Checkout Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                          totalPrice: totalPrice,
                          cartProducts: cartProducts,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3EA120),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Checkout Now (₹$totalPrice)' ,style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;
  final List cartProducts;

  const CheckoutScreen({
    super.key,
    required this.totalPrice,
    required this.cartProducts,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear resources when the screen is disposed
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment successful: ${response.paymentId}')),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External wallet selected: ${response.walletName}')),
    );
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_QLvdqmBfoYL2Eu', // Replace with your Razorpay Key
      'amount': (widget.totalPrice * 100).toInt(), // Razorpay accepts amount in paise
      'name': 'My E-Commerce App',
      'description': 'Purchase from My E-Commerce App',
      'prefill': {
        'contact': '9876543210',
        'email': 'customer@example.com',
      },
      'theme': {
        'color': '#3EA120',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFF3EA120),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Review your order:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartProducts.length,
                itemBuilder: (context, index) {
                  final product = widget.cartProducts[index];
                  return ListTile(
                    title: Text(product['name']),
                    subtitle: Text('₹${product['price']}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _startPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3EA120),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
