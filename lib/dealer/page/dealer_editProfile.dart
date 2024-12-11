// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DealerEditProfilePage extends StatefulWidget {
  const DealerEditProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DealerEditProfilePageState createState() => _DealerEditProfilePageState();
}

class _DealerEditProfilePageState extends State<DealerEditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Form fields controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _contactNumberController = TextEditingController();

  String? _selectedDistrict;
  String? _selectedPlace;

  // Districts in Kerala with places
  final Map<String, List<String>> _keralaDistricts = {
    'Thiruvananthapuram': ['Kovalam', 'Neyyattinkara', 'Varkala', 'Attingal'],
    'Kollam': ['Paravur', 'Kottarakkara', 'Punalur', 'Sasthamcotta'],
    'Ernakulam': ['Aluva', 'Kochi', 'Kothamangalam', 'Muvattupuzha'],
    'Thrissur': ['Guruvayur', 'Kodungallur', 'Chalakudy', 'Irinjalakuda'],
    'Kottayam': ['Ettumanoor', 'Pala', 'Changanassery', 'Vaikom'],
    'Alappuzha': ['Cherthala', 'Haripad', 'Kayamkulam', 'Mavelikkara'],
    'Kannur': ['Thalassery', 'Payyannur', 'Iritty', 'Mattannur'],
    'Kozhikode': ['Koyilandy', 'Vadakara', 'Feroke', 'Ramanattukara'],
    'Malappuram': ['Manjeri', 'Tirur', 'Ponnani', 'Nilambur'],
    'Palakkad': ['Chittur', 'Mannarkkad', 'Ottapalam', 'Shoranur'],
    'Pathanamthitta': ['Adoor', 'Ranni', 'Thiruvalla', 'Konni'],
    'Idukki': ['Munnar', 'Thodupuzha', 'Kattappana', 'Nedumkandam'],
    'Wayanad': ['Kalpetta', 'Sulthan Bathery', 'Mananthavady'],
    'Kasaragod': ['Kanhangad', 'Nileshwaram', 'Uppala'],
  };

  // Dropdown menu for districts
  Widget _buildDistrictDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select District',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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

  // Dropdown menu for places
  Widget _buildPlaceDropdown() {
    if (_selectedDistrict == null) {
      return const SizedBox.shrink();
    }

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Place',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
      validator: (value) => value == null ? 'Please select a place' : null,
    );
  }

  // Save Changes Button
  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3EA120),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile Updated Successfully!')),
          );
        }
      },
      child: const Text('Save Changes', style: TextStyle(fontSize: 18)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF3EA120),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name Field
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your full name' : null,
              ),
              const SizedBox(height: 16),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email address' : null,
              ),
              const SizedBox(height: 16),

              // Current Password Field
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                obscureText: true,
                validator: (value) => value!.isEmpty
                    ? 'Please enter your current password'
                    : null,
              ),
              const SizedBox(height: 16),

              // New Password Field
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a new password' : null,
              ),
              const SizedBox(height: 32),

              // Change Contact Number Section
              const Text(
                'Change Contact Number',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('+91 ', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: TextFormField(
                      controller: _contactNumberController,
                      decoration: InputDecoration(
                        labelText: 'Contact Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.length != 10
                          ? 'Enter a valid 10-digit phone number'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Update Location Section
              const Text(
                'Update Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildDistrictDropdown(),
              const SizedBox(height: 16),
              _buildPlaceDropdown(),
              const SizedBox(height: 32),

              // Save Changes Button
              Center(child: _buildSaveButton()),
            ],
          ),
        ),
      ),
    );
  }
}
