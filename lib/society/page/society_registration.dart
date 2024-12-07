import 'package:flutter/material.dart';
import 'package:milkproject/society/page/homepage.dart';
import 'package:milkproject/society/page/sevices/society_auth.dart'; // Import HomePage

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _navigateToHomePage() {
    // Navigate to the HomePage if all validations pass
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MilkProjectHomePage(),
      ),
    );
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

                    // Contact Number Field
                    TextFormField(
                      controller: contactNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Contact Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the contact number';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit contact number';
                        }
                        return null;
                      },
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

                    // Manager Name Field
                    TextFormField(
                      controller: managerNameController,
                      decoration: InputDecoration(
                        labelText: 'Manager Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the manager\'s name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Manager Contact Number Field
                    TextFormField(
                      controller: managerContactController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Manager Contact Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the manager\'s contact number';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit contact number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                        if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
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
                            {
                              SocietyAuthService().societyRegister(
                                  context: context,
                                  buildingaddress:
                                      buildingAddressController.text,
                                  location: locationController.text,
                                  contactnumber: contactNumberController.text,
                                  managername: managerContactController.text,
                                  managercontact: managerContactController.text,
                                  password: passwordController.text,
                                  email: emailController.text);
                            }
                          }
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                          child:
                          null;
                        },
                        child: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
