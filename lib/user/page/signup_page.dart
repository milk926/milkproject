import 'package:flutter/material.dart';
import 'package:milkproject/user/page/services/user_auth.dart';

class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => UserSignupPageState();
}

class UserSignupPageState extends State<UserSignupPage> {
  // Controllers for each field
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController aadhar = TextEditingController();
  final TextEditingController ration = TextEditingController();
  final TextEditingController bank = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

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
    } else if (value.length != 12 || !RegExp(r'^\d+$').hasMatch(value)) {
      return 'Aadhar number must be 12 digits';
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

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (value.length != 10 || !RegExp(r'^\d+$').hasMatch(value)) {
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  bool loading = false;
  void register() async {
    setState(() {
      loading = true;
    });

    if (_formKey.currentState?.validate() ?? false) {
      await UserAuthService().userRegister(
        context: context,
        name: name.text,
        password: password.text,
        aadhar: aadhar.text,
        ration: ration.text,
        bank: bank.text,
        phone: phone.text,
        email: email.text,
      );
      setState(() {
        loading = false;
      });
    }
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
                  'asset/logo.png',
                  width: 270,
                  height: 250,
                ),
                const SizedBox(height: 16.0),
                // Username field
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Colors.green),
                  ),
                  validator: validateUsername,
                ),
                const SizedBox(height: 16.0),
                // Email field
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: Colors.green),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(height: 16.0),
                // Password field
                TextFormField(
                  controller: password,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.green,
                      ),
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
                // Aadhar number field
                TextFormField(
                  controller: aadhar,
                  decoration: const InputDecoration(
                    labelText: 'Aadhar Number',
                    border: OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.card_membership, color: Colors.green),
                  ),
                  keyboardType: TextInputType.number,
                  validator: validateAadhar,
                ),
                const SizedBox(height: 16.0),
                // Ration number field
                TextFormField(
                  controller: ration,
                  validator: validateRationCard,
                  decoration: const InputDecoration(
                    labelText: 'Ration Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.card_travel, color: Colors.green),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Bank account number field
                TextFormField(
                  controller: bank,
                  decoration: const InputDecoration(
                    labelText: 'Bank Account Number',
                    border: OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.account_balance_wallet, color: Colors.green),
                  ),
                  keyboardType: TextInputType.number,
                  validator: validateBankAccount,
                ),
                const SizedBox(height: 16.0),
                // Phone number field
                TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone, color: Colors.green),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: validatePhone,
                ),
                const SizedBox(height: 20.0),
                // Signup button
                loading
                    ? const Center(child: CircularProgressIndicator())
                    : OutlinedButton(
                        onPressed: () {
                          register();
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
