import 'package:flutter/material.dart';
import 'package:milkproject/farmer/page/dailymilk-quandity.dart';
import 'package:milkproject/farmer/page/dung-cake.dart';
import 'package:milkproject/farmer/page/farmer_profile_page.dart';
import 'package:milkproject/user/page/addtocart.dart';
import 'package:milkproject/user/page/buy_now.dart';


void main() {
  runApp(const MyApp());
}

final List<Map<String, dynamic>> demoProducts = [
      {
        'name': 'cattle feed',
        'price': 450,
        'description': 'This is a sample description for Demo Product 1.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShA5-IzufSUe4yV_FOPOfnS1u-QCPwXHwjuA&s',
      },
      {
        'name': 'hay',
        'price': 120,
        'description': 'This is a sample description for Demo Product 2.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ86-e2WOw0LMIfTzvBrA4lfltpS86ltjJ0DA&s',
      },
      {
        'name': 'green grass',
        'price': 200,
        'description': 'This is a sample description for Demo Product 3.',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVGRRSpqRbq4b7ie-zsQEZkrmP4GiG2nRYbQ&s',
      },
      
    ];




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: const FarmerChoiceScreen(),
    );
  }
}

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

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  FarmerProfileScreen(),
                ),
              );
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
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  productCard(
                    'Cattle Feed              450 per 1 pack',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShA5-IzufSUe4yV_FOPOfnS1u-QCPwXHwjuA&s',
                    context,
                  ),
                  productCard(
                    'Hay               150 per  1 bunddle',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ86-e2WOw0LMIfTzvBrA4lfltpS86ltjJ0DA&s',
                    context,
                  ),
                  productCard(
                    'Green Grass        200 per 1 bunddle',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVGRRSpqRbq4b7ie-zsQEZkrmP4GiG2nRYbQ&s',
                    context,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Daily Milk Details
          
        Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text('Daily Milk Details', style: TextStyle(fontSize: 18)),
            subtitle: Text('Milk Yield: 1 liters\nPrice per liter: ₹60'),
            leading: Icon(Icons.local_drink, size: 40, color: Colors.blue),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  MilkForm(),
                ),
              );
            },
          ),
        ),
            // Cow Dung Cake
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: const Text('Cow Dung Cake', style: TextStyle(fontSize: 18)),
                subtitle: const Text('Price: ₹50\\nAvailable: 1 budget'),
                leading: Image.network(
                  'https://media.istockphoto.com/id/1443057822/vector/compost-bin-icon-waste-clipart-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=emYkaS9ylxy-ccjFDT3WlfF1h9-Nx-dzKbuZAR1IiLI=',
                  width: 40,
                ),
                onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  DungForm(),
                ),
              );
            },
              ),
            ),
            SizedBox(height: 30,),
Row(
  mainAxisAlignment: MainAxisAlignment.center, // Center align the buttons
  children: [
    SizedBox(
      width: 150.0, // Set the desired button width
      child: ElevatedButton(
        onPressed: () {

          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuyNowPage(),
                  ),
                );
          // Handle button press action
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, 
          backgroundColor: const Color.fromARGB(255, 19, 137, 37), // Text color
          padding: EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
          ),
          elevation: 8.0, // Shadow depth
        ),
        child: Text(
          'Buy Now',
          style: TextStyle(
            fontSize: 16.0, // Font size
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
      ),
    ),
    SizedBox(width: 20.0), // Add some spacing between the buttons
    SizedBox(
      width: 150.0, // Set the desired button width
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddToCartPage(cartProducts: demoProducts,),
                  ),
                );
          // Handle second button press actionAddToCartPage
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, 
          backgroundColor: const Color.fromARGB(255, 19, 137, 37), // Text color
          padding: EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
          ),
          elevation: 8.0, // Shadow depth
        ),
        child: Text(
          'Add to Cart',
          style: TextStyle(
            fontSize: 16.0, // Font size
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
      ),
    ),
  ],
)


          ],
        ),
      ),
    );
  }

  // Product Card Widget with Buy Now button
  Widget productCard(String productName, String imagePath, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 5,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.network(imagePath, height: 60, width: 60),
            const SizedBox(height: 5),
            Text(
              productName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            BuyNowButton(),
          ],
        ),
      ),
    );
  }
}

class BuyNowButton extends StatefulWidget {
  const BuyNowButton({Key? key}) : super(key: key);

  @override
  _BuyNowButtonState createState() => _BuyNowButtonState();
}

class _BuyNowButtonState extends State<BuyNowButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Prevents background splash color
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // Prevents default focus indicator
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          // Optionally, show a dialog or trigger some other action on click
          if (isSelected) {
            // Show dialog or something when selected
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product selected!')),
            );
          }
        },
        child: Container(
          width: 40, // Reduced width
          height: 40, // Reduced height
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.greenAccent, // Green background
            shape: BoxShape.circle, // Circle button
          ),
          child: isSelected
              ? const Icon(
                  Icons.check, // White check icon
                  color: Colors.white,
                  size: 25, // Adjusted size of the icon
                )
              : const Icon(
                  Icons.shopping_cart, // Cart icon if not selected
                  color: Colors.white,
                  size: 25, // Adjusted size of the icon
                ),
        ),
      ),
    );
  }
}