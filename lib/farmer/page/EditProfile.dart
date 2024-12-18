import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Firestore and FirebaseAuth instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // TextEditingControllers to hold input values
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cowsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await _firestore
            .collection('farmer') // Replace with your Firestore collection name
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _nameController.text = userDoc['name'] ?? '';
            _emailController.text = userDoc['email'] ?? '';
            _phoneController.text = userDoc['phone'] ?? '';
            _cowsController.text = userDoc['cow']?.toString() ?? '';
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _saveProfile() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('farmer').doc(currentUser.uid).update({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'cow': int.parse(_cowsController.text),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile Updated Successfully!")),
        );
        Navigator.pop(context); // Return to Profile Page
      }
    } catch (e) {
      print("Error saving profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green[200],
                  child: Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Name Field
              Text("Name", style: fieldLabelStyle()),
              TextField(
                controller: _nameController,
                decoration: inputDecoration("Enter your name"),
              ),
              SizedBox(height: 15),

              // Email Field
              Text("Email", style: fieldLabelStyle()),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration("Enter your email"),
              ),
              SizedBox(height: 15),

              // Phone Number Field
              Text("Phone Number", style: fieldLabelStyle()),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: inputDecoration("Enter your phone number"),
              ),
              SizedBox(height: 15),

              // Number of Cows Field
              Text("No. of Cows", style: fieldLabelStyle()),
              TextField(
                controller: _cowsController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration("Enter number of cows"),
              ),
              SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Input Decoration for TextFields
  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.green),
      ),
    );
  }

  // Label Style for the TextFields
  TextStyle fieldLabelStyle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.green[800],
    );
  }
}
