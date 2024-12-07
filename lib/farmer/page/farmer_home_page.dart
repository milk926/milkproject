import 'package:flutter/material.dart';

class FarmerChoiceScreen extends StatelessWidget {
  const FarmerChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer\'s Choice'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Products Section
            const Text(
              'Choose Your Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  productCard('Milk', 'assets/milk.png'),
                  productCard('Butter', 'assets/butter.png'),
                  productCard('Cheese', 'assets/cheese.png'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Daily Milk Details
            const Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title:
                    Text('Daily Milk Details', style: TextStyle(fontSize: 18)),
                subtitle: Text('Milk Yield: 35 liters\nPrice per liter: \$2'),
                leading: Icon(Icons.local_drink, size: 40, color: Colors.blue),
              ),
            ),

            // Cow Dung Cake
            const Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Cow Dung Cake', style: TextStyle(fontSize: 18)),
                subtitle: Text('Price: \$5\nAvailable: 100 cakes'),
                leading: Icon(Icons.recycling, size: 40, color: Colors.brown),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Product Card Widget
  Widget productCard(String productName, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 5,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(imagePath, height: 60, width: 60),
            const SizedBox(height: 5),
            Text(
              productName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
