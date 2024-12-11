import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers for text fields
  final TextEditingController nameController =
      TextEditingController(text: "John Doe");
  final TextEditingController aadharController =
      TextEditingController(text: "1234-5678-9012");
  final TextEditingController rationController =
      TextEditingController(text: "RAT123456789");
  final TextEditingController bankController =
      TextEditingController(text: "1234567890");
  final TextEditingController phoneController =
      TextEditingController(text: "+1234567890");
  final TextEditingController emailController =
      TextEditingController(text: "john.doe@example.com");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Name Field
                _buildEditableField("Name", nameController, "Enter your name"),
                const SizedBox(height: 10),

                // Aadhar Field
                _buildEditableField(
                    "Aadhar", aadharController, "Enter your Aadhar number",
                    keyboardType: TextInputType.number),

                const SizedBox(height: 10),

                // Ration Number Field
                _buildEditableField("Ration Number", rationController,
                    "Enter your ration number"),

                const SizedBox(height: 10),

                // Bank Details Field
                _buildEditableField("A/C Number", bankController,
                    "Enter your bank account number",
                    keyboardType: TextInputType.number),

                const SizedBox(height: 10),

                // Phone Field
                _buildEditableField(
                    "Phone", phoneController, "Enter your phone number",
                    keyboardType: TextInputType.phone),

                const SizedBox(height: 10),

                // Email Field
                _buildEditableField(
                    "Email", emailController, "Enter your email address",
                    keyboardType: TextInputType.emailAddress),

                const SizedBox(height: 30),

                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Save changes and return to Profile Page
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Profile updated successfully!")),
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Save Changes",
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
    );
  }

  // Helper function to build editable text fields
  Widget _buildEditableField(
      String label, TextEditingController controller, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.8),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }
}
