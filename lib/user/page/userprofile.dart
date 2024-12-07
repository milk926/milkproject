import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:milkproject/firebase_options.dart';
import 'package:milkproject/user/page/edit_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfileScreen(),
    ),
  );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy user data
  
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Profile"),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return EditProfileScreen();
                  },
                ));
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return (CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return (Text('data not available'));
            } else {
              final profiledata= snapshot.data?.data();
              print('profiledata');
              return conatainerCenter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Icon
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green.withOpacity(0.2),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),

              // User Details in Cards
              _buildInfoCard("Name", name),
              const SizedBox(height: 10),
              _buildInfoCard("Aadhar", aadhar),
              const SizedBox(height: 10),
              _buildInfoCard("Ration Number", rationNumber),
              const SizedBox(height: 10),
              _buildInfoCard("A/C Number", bankDetails),
              const SizedBox(height: 10),
              _buildInfoCard("Phone", phone),
              const SizedBox(height: 10),
              _buildInfoCard("Email", email),
              const SizedBox(height: 30),

              // Logout Button
              ElevatedButton(
                onPressed: () {
                  // Logout logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Logged out! Redirect to login page')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 60.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

              )
            }
            }
          
          },
        ));
  }

  // Helper function to build an info card
  Widget _buildInfoCard(String label, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
