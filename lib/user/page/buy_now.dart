import 'package:flutter/material.dart';

class BuyNowPage extends StatefulWidget {
  BuyNowPage(Map map);

  @override
  _BuyNowPageState createState() => _BuyNowPageState();
}

class _BuyNowPageState extends State<BuyNowPage> {
  int quantity = 1;
  String? deliveryAddress;
  bool useSuperCoins = false;
  DateTime? selectedDate;
  String paymentMethod = 'Credit/Debit Card';

  final List<String> paymentOptions = [
    'Credit/Debit Card',
    'Net Banking',
    'UPI',
    'Wallets',
    'Cash on Delivery',
    'Gift Cards'
  ];

  void _selectDeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
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
        title: Text('Checkout'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[800]!, Colors.blue[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
                  _buildProgressStep("Payment", false),
                ],
              ),
              SizedBox(height: 16),

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
              SizedBox(height: 16),

              // Delivery Address Section
              _buildSectionCard(
                icon: Icons.location_on,
                title: "Delivery Address",
                child: TextField(
                  onChanged: (value) => deliveryAddress = value,
                  decoration: InputDecoration(
                    hintText: 'Enter delivery address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),

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
              SizedBox(height: 16),

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
                    style: TextStyle(fontSize: 16, color: Colors.blue[800]),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Payment Methods Section
              _buildSectionCard(
                icon: Icons.payment,
                title: "Payment Methods",
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
              SizedBox(height: 16),

              // Place Order Button
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.check_circle),
                  label: Text('Place Order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the Payment Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(paymentMethod: paymentMethod),
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

  Widget _buildSectionCard({required IconData icon, required String title, required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue[800]),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            child,
          ],
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
        SizedBox(height: 4),
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

class PaymentPage extends StatelessWidget {
  final String paymentMethod;

  PaymentPage({required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Text(
          "Proceed with $paymentMethod",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
