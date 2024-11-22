import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking document images

class SocietyRegistrationScreen extends StatefulWidget {
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
  final TextEditingController contactNumberController =
      TextEditingController();
  final TextEditingController licenseNumberController =
      TextEditingController();
  final TextEditingController managerNameController = TextEditingController();
  final TextEditingController managerContactController =
      TextEditingController();
  XFile? _document; // To hold the selected document image

  // Function to pick the document image
  Future<void> _pickDocument() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _document = pickedFile;
    });
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
              key: _formKey, // Attach the form key for validation
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // "Society Registration" text
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
                      if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)) {
                        return 'Please enter a valid contact number';
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
                      if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)) {
                        return 'Please enter a valid contact number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Upload Document Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3EA120),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 60.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _pickDocument,
                    child: const Text(
                      'Upload Document',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // If a document is selected, show the document name
                  if (_document != null)
                    Text(
                      'Document Selected: ${_document!.name}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),

                  const SizedBox(height: 20),

                  // Full-Width Register Button
                  SizedBox(
                    width: double.infinity, // This ensures the button is full width
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
                        // Validate the form before proceeding
                        if (_formKey.currentState?.validate() ?? false) {
                          // Handle successful registration logic
                          String buildingAddress =
                              buildingAddressController.text;
                          String location = locationController.text;
                          String pincode = pincodeController.text;
                          String contactNumber = contactNumberController.text;
                          String licenseNumber = licenseNumberController.text;
                          String managerName = managerNameController.text;
                          String managerContact =
                              managerContactController.text;

                          // Example: print the data (you could send this to a server)
                          print(
                              'Society Registered: Address: $buildingAddress, Location: $location, Pincode: $pincode, Contact: $contactNumber, License: $licenseNumber, Manager: $managerName, Manager Contact: $managerContact');
                        } else {
                          // Show an error message if validation fails
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please fill all fields correctly')),
                          );
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
