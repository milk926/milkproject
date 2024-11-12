mport 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  // Controllers for each field
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController aadhar = TextEditingController();
  TextEditingController ration = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController phone = TextEditingController();
  
  // State for password visibility toggle
  bool showPassword = true;
  
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Validation functions
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateAadhar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Aadhar number cannot be empty';
    } else if (value.length != 12) {
      return 'Aadhar number must be 12 digits';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  String? validateBankAccount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bank account number cannot be empty';
    }
    return null;
  }

  String? validateRationCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ration Card number cannot be empty';
    } else if (value.length < 10 || value.length > 15) {
      return 'Ration Card number must be between 10 and 15 characters';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Ration Card number should only contain alphanumeric characters';
    }
    return null;
  }

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    aadhar.dispose();
    ration.dispose();
    bank.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup Page')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'asset/29319f53b462e0e20000f77710213461.png',
                  width: 270,
                  height: 250,
                ),
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: validateUsername,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: password,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  validator: validatePassword,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: aadhar,
                  decoration: const InputDecoration(
                    labelText: 'Aadhar Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: validateAadhar,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: ration,
                  decoration: const InputDecoration(
                    labelText: 'Ration Card Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: validateRationCard,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: bank,
                  decoration: const InputDecoration(
                    labelText: 'Bank Account Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: validateBankAccount,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: validatePhone,
                ),
                const SizedBox(height: 20.0),
                OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Signup Successful')),
                      );
                      print('Username: ${name.text}');
                      print('Password: ${password.text}');
                      print('Aadhar: ${aadhar.text}');
                      print('Phone: ${phone.text}');
                      print('Ration Card: ${ration.text}');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Validation failed')),
                      );
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}