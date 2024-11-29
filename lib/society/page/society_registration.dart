import 'package:flutter/material.dart';
import 'package:milkproject/society/page/homepage.dart'; // Import HomePage

class SocietyRegistrationScreen extends StatefulWidget {
  const SocietyRegistrationScreen({super.key});

  @override
  _SocietyRegistrationScreenState createState() =>
      _SocietyRegistrationScreenState();
}

class _SocietyRegistrationScreenState extends State<SocietyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController buildingAddressController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController managerNameController = TextEditingController();
  final TextEditingController managerContactController =
      TextEditingController();

  void _navigateToHomePage() {
    // Check if all fields are filled
    if (buildingAddressController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty &&
        contactNumberController.text.isNotEmpty &&
        licenseNumberController.text.isNotEmpty &&
        managerNameController.text.isNotEmpty &&
        managerContactController.text.isNotEmpty) {
      // Navigate to the HomePage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MilkProjectHomePage(),
        ),
      );
    } else {
      // Show error message if not all fields are filled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields before proceeding')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Society Registration',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Building Address Field
                  TextFormField(
                    controller: buildingAddressController,
                    decoration: InputDecoration(
                      labelText: 'Building Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the building address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Location Field
                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Pincode Field
                  TextFormField(
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Pincode',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the pincode';
                      }
                      if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                        return 'Please enter a valid 6-digit pincode';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Contact Number Field (No validation required)
                  TextFormField(
                    controller: contactNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // License Number Field
                  TextFormField(
                    controller: licenseNumberController,
                    decoration: InputDecoration(
                      labelText: 'License Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the license number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Manager Name Field (No validation required)
                  TextFormField(
                    controller: managerNameController,
                    decoration: InputDecoration(
                      labelText: 'Manager Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Manager Contact Number Field (No validation required)
                  TextFormField(
                    controller: managerContactController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Manager Contact Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3EA120),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _navigateToHomePage();
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
