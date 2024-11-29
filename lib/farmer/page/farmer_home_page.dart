import 'package:flutter/material.dart';

class FarmerChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer\'s Choice'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
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
            Text(
              'Choose Your Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
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
            SizedBox(height: 20),

            // Daily Milk Details
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Daily Milk Details', style: TextStyle(fontSize: 18)),
                subtitle: Text('Milk Yield: 35 liters\nPrice per liter: \$2'),
                leading: Icon(Icons.local_drink, size: 40, color: Colors.blue),
              ),
            ),

            // Cow Dung Cake
            Card(
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
      margin: EdgeInsets.symmetric(horizontal: 10),
      elevation: 5,
      child: Container(
        width: 120,
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(imagePath, height: 60, width: 60),
            SizedBox(height: 5),
            Text(
              productName,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}