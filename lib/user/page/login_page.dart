import 'package:flutter/material.dart';
import 'package:milkproject/user/page/homepageuser.dart';
import 'package:milkproject/user/page/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Function to handle login
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // If form is valid, print credentials (You can replace this with actual login logic)
      String email = _emailController.text;
      String password = _passwordController.text;
      print("Email: $email");
      print("Password: $password");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
        
      },));

      // Navigate to home page or another screen after successful login
      // Navigator.pushReplacementNamed(context, '/home');  // Replace with your home route
    } else {
      // Show error if form is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid email and password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email TextField
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              // Password TextField
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),

              // Text button for navigation to Sign Up page
              TextButton(
                onPressed: () {
                  // Corrected navigation to SignupPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()), // Correct way to push SignupPage
                  );
                },
                child: Text(
                  'Don’t have an account? Sign up',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy SignupPage for the sake of example, replace with your actual SignupPage implementation
