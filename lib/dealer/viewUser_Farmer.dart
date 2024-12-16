import 'package:flutter/material.dart';

class ViewUserFarmerPage extends StatelessWidget {
  const ViewUserFarmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewUserFarmerScreen(),
    );
  }
}

class ViewUserFarmerScreen extends StatefulWidget {
  const ViewUserFarmerScreen({super.key});

  @override
  _ViewUserFarmerScreenState createState() => _ViewUserFarmerScreenState();
}

class _ViewUserFarmerScreenState extends State<ViewUserFarmerScreen> {
  final List<Map<String, String>> users = [
    {'name': 'John Doe', 'email': 'johndoe@example.com', 'phone': '9876543210'},
    {'name': 'Alice Smith', 'email': 'alicesmith@example.com', 'phone': '8765432109'},
    {'name': 'Rajesh Kumar', 'email': 'rajesh@example.com', 'phone': '7654321098'},
    {'name': 'Anjali Sharma', 'email': 'anjali@example.com', 'phone': '6543210987'},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users
        .where((user) => user['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Users/Farmers'),
        backgroundColor: Colors.green.shade800,
      ),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/green_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                backgroundBlendMode: BlendMode.overlay,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search users/farmers by name',
                    prefixIcon: const Icon(Icons.search, color: Colors.green),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade800,
                          child: Text(
                            user['name']![0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          user['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: ${user['email']}'),
                            Text('Phone: ${user['phone']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}