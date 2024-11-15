import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Right drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      ),
      
      appBar: AppBar(
        centerTitle: true, // Center the title
        title: Image.asset(
          'asset/29319f53b462e0e20000f77710213461.png', // Your logo
          height: 40,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Open the drawer
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      
      body: SingleChildScrollView( // Wrap the body with a scroll view
        child: Column(
          children: <Widget>[
            // Banner Image Section
            Container( 
              width: double.infinity, // Make it full width
              child: Image.asset(
                'asset/ai-generated-7483596_960_720.jpg', // Path to your banner image
                fit: BoxFit.cover,    // Ensures the image covers the area
                height: 200,          // Adjust height as needed
              ),
            ),
            
            // Main content section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to the Home Screen!',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'This is the home page where you can introduce your app.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
