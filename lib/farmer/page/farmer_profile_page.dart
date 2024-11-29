import 'package:flutter/material.dart';

class FarmerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green,
                  backgroundImage: AssetImage('assets/farmer_image.jpg'), // Add a placeholder image
                ),
              ),
              SizedBox(height: 20),

              // Farmer's Name with Icon
              Row(
                children: [
                  Icon(Icons.person, size: 30, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'John Doe', // Replace with dynamic data
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),

              // Phone Number with Icon
              Row(
                children: [
                  Icon(Icons.phone, size: 30, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    'Phone Number:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '+123 456 7890', // Replace with dynamic data
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),

              // Number of Cows with Icon
              Row(
                children: [
                  Image.asset('asset/cow (1).png', width: 30, height: 30,color: Colors.green,),
                  SizedBox(width: 10),
                  Text(
                    'Number of Cows:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '25', // Replace with dynamic data
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),

              // Show Documents Section with Icon
              Row(
                children: [
                  Icon(Icons.document_scanner, size: 30, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    'Show Documents:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Add logic to view or upload documents
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Document Viewer"),
                        content: Text("Display or Upload Documents here."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'View Documents',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Green color for the button
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
