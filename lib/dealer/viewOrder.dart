import 'package:flutter/material.dart';

class ViewOrderDetailsPage extends StatelessWidget {
  const ViewOrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.green.shade800,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/background.jpg'), // Add your background image
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [Colors.green.shade100.withOpacity(0.8), Colors.green.shade500.withOpacity(0.8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order ID: ${order['id']}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Chip(
                          label: Text(order['status']),
                          backgroundColor: order['status'] == 'Delivered'
                              ? Colors.green.shade300
                              : Colors.orange.shade300,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Order Date: ${order['orderDate']}'),
                    Text('Delivered Date: ${order['deliveredDate']}'),
                    const Divider(height: 20, thickness: 1.0),
                    const Text(
                      'Items Ordered:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...order['items'].map<Widget>((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item['name']),
                            Text('₹${item['price'].toStringAsFixed(2)}'),
                          ],
                        ),
                      );
                    }).toList(),
                    const Divider(height: 20, thickness: 1.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('₹${order['totalPrice'].toStringAsFixed(2)}'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> orders = [
  {
    'id': 'ORD001',
    'orderDate': '2024-01-01',
    'deliveredDate': '2024-01-03',
    'status': 'Delivered',
    'items': [
      {'name': 'Milk', 'price': 50.0},
      {'name': 'Cheese', 'price': 200.0},
      {'name': 'Butter', 'price': 150.0},
    ],
    'totalPrice': 400.0,
  },
  {
    'id': 'ORD002',
    'orderDate': '2024-01-02',
    'deliveredDate': '2024-01-05',
    'status': 'Pending',
    'items': [
      {'name': 'Milk', 'price': 50.0},
      {'name': 'Ghee', 'price': 300.0},
    ],
    'totalPrice': 350.0,
  },
];
