import 'package:flutter/material.dart';
import 'package:milkproject/farmer/page/farmer_registration_page.dart';
import 'package:milkproject/user/page/signup_page.dart';
import 'package:milkproject/society/page/society_registration.dart';
import 'package:milkproject/dealer/page/dealer_registration_page.dart';


class ChooseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            // Title Text
            const Text(
              'Choose Your Role',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),

            // Admin Card (with outline)
            GestureDetector(
              onTap: () {
                // Navigate to Admin Screen or handle logic
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FarmerRegistrationScreen(),
                    ));
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Color(0xFF3EA120), // Outline color
                    width: 2, // Border width
                  ),
                ),
                elevation: 5,
                child: Container(
                  width: 300,
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.admin_panel_settings,
                        size: 40,
                        color: Color(0xFF3EA120), // Icon color to match border
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Farmer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              Color(0xFF3EA120), // Text color to match border
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // User Card (with outline)
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserSignupPage(),
                    ));
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Color(0xFF3EA120), // Outline color
                    width: 2, // Border width
                  ),
                ),
                elevation: 5,
                child: Container(
                  width: 300,
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF3EA120), // Icon color to match border
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'User',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              Color(0xFF3EA120), // Text color to match border
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Society Card (with outline)
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SocietyRegistrationScreen(),
                    ));
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Color(0xFF3EA120), // Outline color
                    width: 2, // Border width
                  ),
                ),
                elevation: 5,
                child: Container(
                  color: Colors.white,
                  width: 300,
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        size: 40,
                        color: Color(0xFF3EA120), // Icon color to match border
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Society',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              Color(0xFF3EA120), // Text color to match border
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Society Card (with outline)
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DealerRegistrationScreen(),
                    ));
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Color(0xFF3EA120), // Outline color
                    width: 2, // Border width
                  ),
                ),
                elevation: 5,
                child: Container(
                  color: Colors.white,
                  width: 300,
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        size: 40,
                        color: Color(0xFF3EA120), // Icon color to match border
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Dealer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              Color(0xFF3EA120), // Text color to match border
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
