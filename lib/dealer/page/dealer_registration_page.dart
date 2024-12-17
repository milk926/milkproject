import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milkproject/dealer/services/dealer_auth.dart';

class DealerRegistrationScreen extends StatefulWidget {
  const DealerRegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DealerRegistrationScreenState createState() =>
      _DealerRegistrationScreenState();
}

class _DealerRegistrationScreenState extends State<DealerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController aadharNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // For location dropdowns
  String? _selectedDistrict;
  String? _selectedPlace;

  // Districts in Kerala with localities
  final Map<String, List<String>> _keralaDistricts = {
    'Thiruvananthapuram': ['Kovalam', 'Neyyattinkara', 'Varkala', 'Attingal'],
    'Kollam': ['Paravur', 'Kottarakkara', 'Punalur', 'Sasthamcotta'],
    'Ernakulam': ['Aluva', 'Kochi', 'Kothamangalam', 'Muvattupuzha'],
    'Thrissur': ['Guruvayur', 'Kodungallur', 'Chalakudy', 'Irinjalakuda'],
    'Kottayam': ['Ettumanoor', 'Pala', 'Changanassery', 'Vaikom'],
    'Alappuzha': ['Cherthala', 'Haripad', 'Kayamkulam', 'Mavelikkara'],
    'Kannur': [
      'Thalassery', 'Payyannur', 'Iritty', 'Mattannur', 'Kannur City',
      'Koothuparamba', 'Peravoor', 'Puzhathi', 'Sreekandapuram',
      'Kadannappally',
      'Anjarakkandy', 'Chavassery' // Added milk society places
    ],
    'Kozhikode': ['Koyilandy', 'Vadakara', 'Feroke', 'Ramanattukara'],
    'Malappuram': ['Manjeri', 'Tirur', 'Ponnani', 'Nilambur'],
    'Palakkad': ['Chittur', 'Mannarkkad', 'Ottapalam', 'Shoranur'],
    'Pathanamthitta': ['Adoor', 'Ranni', 'Thiruvalla', 'Konni'],
    'Idukki': ['Munnar', 'Thodupuzha', 'Kattappana', 'Nedumkandam'],
    'Wayanad': ['Kalpetta', 'Sulthan Bathery', 'Mananthavady'],
    'Kasaragod': ['Kanhangad', 'Nileshwaram', 'Uppala'],
  };

  // To toggle password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Function to pick the document image
  Future<void> _pickDocument() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {});
    }
  }

  // Dropdown menu for districts
  Widget _buildDistrictDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'District',
        labelStyle: TextStyle(color: Colors.green[700]), // Green label
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.green[50], // Light green background
      ),
      value: _selectedDistrict,
      items: _keralaDistricts.keys
          .map((district) =>
              DropdownMenuItem(value: district, child: Text(district)))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedDistrict = value;
          _selectedPlace = null; // Reset selected place
        });
      },
      validator: (value) => value == null ? 'Please select a district' : null,
    );
  }

  // Dropdown menu for localities
  Widget _buildPlaceDropdown() {
    if (_selectedDistrict == null) {
      return const SizedBox.shrink();
    }
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Locality',
        labelStyle: TextStyle(color: Colors.green[700]), // Green label
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.green[50], // Light green background
      ),
      value: _selectedPlace,
      items: _keralaDistricts[_selectedDistrict]!
          .map((place) => DropdownMenuItem(value: place, child: Text(place)))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedPlace = value;
        });
      },
      validator: (value) => value == null ? 'Please select a locality' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50], // Light green background
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dealer Registration',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // Green title
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name Field
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: Colors.green[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.green[50],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
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
                      labelStyle: TextStyle(color: Colors.green[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.green[50],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Contact Number Field with +91
                  TextFormField(
                    controller: contactNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixText: '+91 ',
                      labelText: 'Contact Number',
                      labelStyle: TextStyle(color: Colors.green[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.green[50],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact number';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Aadhaar Number Field
                  TextFormField(
                    controller: aadharNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Aadhaar Number',
                      labelStyle: TextStyle(color: Colors.green[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.green[50],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Aadhaar number';
                      }
                      if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                        return 'Please enter a valid 12-digit Aadhaar number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.green[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.green[50],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
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

                  // Confirm Password Field
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle:
                          const TextStyle(color: Color.fromARGB(255, 5, 19, 5)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.green[50],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // District Dropdown
                  _buildDistrictDropdown(),
                  const SizedBox(height: 20),

                  // Place Dropdown
                  _buildPlaceDropdown(),
                  const SizedBox(height: 20),

                  // Upload Document Button
                  Center(
                    child: ElevatedButton(
                      onPressed: _pickDocument,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Upload Document'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Register Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Proceed with registration
                          DealerAuthService().dealerRegister(
                              context: context,
                              name: nameController.text,
                              password: passwordController.text,
                              aadhar: aadharNumberController.text,
                              phone: contactNumberController.text,
                              email: emailController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green[700], // Darker green for action button
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Register'),
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
