import 'package:flutter/material.dart';

class BuyNowPage extends StatefulWidget {
  const BuyNowPage({super.key});

  @override
  _BuyNowPageState createState() => _BuyNowPageState();
}

class _BuyNowPageState extends State<BuyNowPage> {
  int quantity = 1;
  String? deliveryAddress;
  bool useSuperCoins = false;
  DateTime? selectedDate;
  String paymentMethod = 'Cash on Delivery'; // Default to COD

  final List<String> paymentOptions = [
    'Cash on Delivery',
  ];

  void _selectDeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.green[800],
      ),
      body: Container(
        color: Colors.white, // Background color set to white
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProgressStep("Cart", true),
                  _buildProgressConnector(),
                  _buildProgressStep("Details", true),
                  _buildProgressConnector(),
                  _buildProgressStep("Confirm", false),
                ],
              ),
              const SizedBox(height: 16),

              // Quantity Section
              _buildSectionCard(
                icon: Icons.shopping_cart,
                title: "Select Quantity",
                child: DropdownButton<int>(
                  value: quantity,
                  items: List.generate(10, (index) => index + 1)
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      quantity = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Delivery Address Section
              _buildSectionCard(
                icon: Icons.location_on,
                title: "Delivery Address",
                child: TextField(
                  onChanged: (value) => deliveryAddress = value,
                  decoration: const InputDecoration(
                    hintText: 'Enter delivery address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // SuperCoins Section
              _buildSectionCard(
                icon: Icons.stars,
                title: "Use SuperCoins",
                child: Switch(
                  value: useSuperCoins,
                  onChanged: (value) {
                    setState(() {
                      useSuperCoins = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Delivery Date Section
              _buildSectionCard(
                icon: Icons.calendar_today,
                title: "Delivery Date",
                child: TextButton(
                  onPressed: () => _selectDeliveryDate(context),
                  child: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : '${selectedDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 16, color: Colors.green[800]),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Payment Methods Section
              _buildSectionCard(
                icon: Icons.payment,
                title: "Payment Method",
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: paymentMethod,
                  items: paymentOptions
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Place Order Button
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Place Order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    if (deliveryAddress == null || deliveryAddress!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a delivery address!'),
                        ),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Order placed successfully for $quantity item(s) to $deliveryAddress using $paymentMethod!',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
      {required IconData icon, required String title, required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.green.withOpacity(0.5), width: 2), // Green border
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.green[800]),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStep(String title, bool isCompleted) {
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isCompleted ? Colors.green : Colors.grey,
          child: Icon(
            isCompleted ? Icons.check : Icons.circle,
            size: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isCompleted ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressConnector() {
    return Container(
      width: 30,
      height: 2,
      color: Colors.grey,
    );
  }
}
