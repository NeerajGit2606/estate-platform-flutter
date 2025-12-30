// Imports Flutter material UI components
import 'package:flutter/material.dart';

// Imports Firebase Authentication package
import 'package:firebase_auth/firebase_auth.dart';

// Imports login screen shown when user is not authenticated
import '../features/auth/login_screen.dart';

// Imports role selection screen shown after successful login
import '../features/auth/role_selection_screen.dart';

// AuthGate widget decides which screen to show
// based on the user's authentication state
class AuthGate extends StatelessWidget {

  // Constructor with optional key
  const AuthGate({super.key});

  // Builds the UI depending on authentication state
  @override
  Widget build(BuildContext context) {

    // StreamBuilder listens to Firebase authentication state changes
    return StreamBuilder<User?>(
      
      // Stream emits User object when logged in, null when logged out
      stream: FirebaseAuth.instance.authStateChanges(),

      // Builder rebuilds UI whenever auth state changes
      builder: (context, snapshot) {

        // While checking authentication status, show loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If no user is logged in, show login screen
        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        // If user is logged in, navigate to role selection screen
        return const RoleSelectionScreen();
      },
    );
  }
}
