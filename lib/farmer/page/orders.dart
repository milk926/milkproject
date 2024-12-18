import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  // Sample Data for Orders
  final List<Map<String, String>> orders = [
    {
      "date": "2024-06-10",
      "productName": "Cattle Feed Premium",
      "quantity": "2 Bags",
      "totalPrice": "\$40",
      "status": "Delivered",
    },
    {
      "date": "2024-06-09",
      "productName": "Mineral Mixture",
      "quantity": "1 Bag",
      "totalPrice": "\$25",
      "status": "Pending",
    },
    {
      "date": "2024-06-08",
      "productName": "Silage",
      "quantity": "3 Bundles",
      "totalPrice": "\$75",
      "status": "Delivered",
    },
    {
      "date": "2024-06-07",
      "productName": "Concentrated Feed",
      "quantity": "1 Bag",
      "totalPrice": "\$30",
      "status": "In Transit",
    },
    {
      "date": "2024-06-06",
      "productName": "Cattle Feed Basic",
      "quantity": "2 Bags",
      "totalPrice": "\$35",
      "status": "Pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[800]!, Colors.green[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Date and Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date: ${order['date']}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        Chip(
                          label: Text(
                            order['status']!,
                            style: TextStyle(
                              color: order['status'] == "Delivered"
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          backgroundColor: getStatusColor(order['status']!),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey.shade300),
                    SizedBox(height: 6),

                    // Product Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Product:",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          order['productName']!,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),

                    // Quantity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity:",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          order['quantity']!,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),

                    // Total Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Price:",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          order['totalPrice']!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
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
      ),
    );
  }

  // Helper function to determine status color
  Color getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Pending":
        return Colors.orangeAccent;
      case "In Transit":
        return Colors.blueAccent;
      default:
        return Colors.grey;
    }
  }
}
