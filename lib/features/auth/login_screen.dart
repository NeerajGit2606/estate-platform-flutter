// Imports Flutter material UI components
import 'package:flutter/material.dart';

// Imports the authentication service for login functionality
import '../../core/services/auth_service.dart';

// Login screen widget using StatefulWidget
// StatefulWidget is required because we manage controllers and async actions
class LoginScreen extends StatefulWidget {

  // Constructor with optional key
  const LoginScreen({super.key});

  // Creates the mutable state for LoginScreen
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// State class that holds UI logic and data
class _LoginScreenState extends State<LoginScreen> {

  // Controller to read and manage email text field input
  final _email = TextEditingController();

  // Controller to read and manage password text field input
  final _password = TextEditingController();

  // Instance of AuthService to perform authentication operations
  final _auth = AuthService();

  // Async method to handle user login
  Future<void> _login() async {

    // Calls signIn method from AuthService with user input
    await _auth.signIn(
      email: _email.text,       // Email entered by user
      password: _password.text // Password entered by user
    );
  }

  // Builds the UI of the login screen
  @override
  Widget build(BuildContext context) {

    // Scaffold provides basic page layout structure
    return Scaffold(

      // App bar with screen title
      appBar: AppBar(
        title: const Text('Login'),
      ),

      // Body content with padding
      body: Padding(
        padding: const EdgeInsets.all(16),

        // Column arranges widgets vertically
        child: Column(
          children: [

            // Email input field
            TextField(
              controller: _email, // Connects controller to text field
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),

            // Password input field (text hidden)
            TextField(
              controller: _password, // Connects controller to text field
              obscureText: true,     // Masks password input
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),

            // Adds vertical spacing
            const SizedBox(height: 20),

            // Login button
            ElevatedButton(
              onPressed: _login,        // Triggers login function
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
