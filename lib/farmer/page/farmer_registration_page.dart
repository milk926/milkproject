import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:milkproject/farmer/page/HomePage.dart';
import 'package:milkproject/farmer/services/farmer_auth.dart';

class FarmerRegistrationScreen extends StatefulWidget {
  const FarmerRegistrationScreen({Key? key}) : super(key: key);

  @override
  _FarmerRegistrationScreenState createState() =>
      _FarmerRegistrationScreenState();
}

class _FarmerRegistrationScreenState extends State<FarmerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController cowsController = TextEditingController();
  XFile? _document; // To hold the selected document image
  bool _isPasswordVisible = false;
  bool _isUploading = false; // Track the upload process

  // Cloudinary details
  final String cloudinaryUrl =
      'https://api.cloudinary.com/v1_1/dsdvk2lms/image/upload';
  final String uploadPreset = 'milk project'; // Replace with your preset

  // Function to pick the document image (e.g., farmer's ID or farm document)
  Future<void> _pickDocument() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _document = pickedFile;
    });
  }

  // Upload the selected document to Cloudinary
  Future<String?> _uploadDocumentToCloudinary(XFile file) async {
    try {
      setState(() {
        _isUploading = true;
      });

      final bytes = await file.readAsBytes();
      final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
        ..fields['upload_preset'] = uploadPreset
        ..files.add(
            http.MultipartFile.fromBytes('file', bytes, filename: file.name));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final json = jsonDecode(responseData);
        return json['secure_url']; // Cloudinary URL of the uploaded file
      } else {
        throw Exception('Failed to upload document: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading document: $e');
      return null;
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  // Submit registration form
  Future<void> _registerFarmer() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_document == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload a document')),
        );
        return;
      }

      // Upload the document and get the URL
      final documentUrl = await _uploadDocumentToCloudinary(_document!);
      if (documentUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload the document')),
        );
        return;
      }

      // Register the farmer
      FarmerAuthService authService = FarmerAuthService();
      await authService.societyRegister(
        context: context,
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        cow: cowsController.text.trim(),
        email: emailController.text.trim(),
        documentUrl: documentUrl,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(148, 207, 255, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Farmer Registration',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: nameController,
                    label: 'Name',
                    icon: Icons.person,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: emailController,
                    label: 'Email Address',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your email';
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter your phone number'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  _buildPasswordField(passwordController, 'Password'),
                  const SizedBox(height: 20),
                  _buildPasswordField(
                      confirmPasswordController, 'Confirm Password',
                      validator: (value) {
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  }),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: cowsController,
                    label: 'Number of Cows',
                    icon: Icons.local_florist,
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter the number of cows'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickDocument,
                    child: const Text('Upload Document'),
                  ),
                  if (_document != null) Text('Selected: ${_document!.name}'),
                  const SizedBox(height: 20),
                  _isUploading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _registerFarmer,
                          child: const Text('Register'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordField(
    TextEditingController controller,
    String label, {
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: validator,
    );
  }
}
