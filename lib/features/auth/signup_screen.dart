import 'package:flutter/material.dart';

// Service responsible ONLY for Firebase Authentication
// (login / signup / logout)
import '../../core/services/auth_service.dart';

// Repository responsible ONLY for Firestore user profile data
// (role, metadata, business rules)
import '../../core/services/user_repository.dart';

// Enum defining allowed business roles in the system
import '../../shared/enums/user_role.dart';

/// =======================================================
/// SIGNUP SCREEN
/// =======================================================
/// Purpose:
/// - Create a new Firebase authenticated user
/// - Assign a permanent business role
/// - Store user profile in Firestore
/// - Do NOT handle routing (AuthGate does that)
///
/// Industry Standard Rules:
/// - Authentication ≠ Authorization
/// - Auth creates identity (uid)
/// - Firestore stores business role
/// - Routing is centralized
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  /// -------------------------------------------------------
  /// CONTROLLERS
  /// -------------------------------------------------------

  /// Controller to read email input from TextField
  final TextEditingController _emailController = TextEditingController();

  /// Controller to read password input from TextField
  final TextEditingController _passwordController = TextEditingController();

  /// -------------------------------------------------------
  /// BUSINESS STATE
  /// -------------------------------------------------------

  /// Selected role by the user
  /// Nullable because user might not select initially
  UserRole? _selectedRole;

  /// -------------------------------------------------------
  /// SERVICES (DEPENDENCIES)
  /// -------------------------------------------------------

  /// AuthService handles Firebase Authentication only
  final AuthService _authService = AuthService();

  /// UserRepository handles Firestore user profile
  final UserRepository _userRepository = UserRepository();

  /// -------------------------------------------------------
  /// SIGNUP BUSINESS LOGIC
  /// -------------------------------------------------------
  /// Flow:
  /// 1. Validate role selection
  /// 2. Create user in Firebase Auth
  /// 3. Store role & metadata in Firestore
  /// 4. Let AuthGate auto-route user
  Future<void> _signup() async {
    // STEP 0: Validate role selection
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a role'),
        ),
      );
      return;
    }

    try {
      // STEP 1: Create user in Firebase Authentication
      // Firebase returns a UserCredential object
      final credential = await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // STEP 2: Persist business profile in Firestore
      // This is where role becomes permanent
      await _userRepository.createUser(
        uid: credential.user!.uid, // Firebase UID (primary identity)
        email: _emailController.text.trim(),
        role: _selectedRole!,
      );

      // STEP 3: NO navigation here
      // ----------------------------------
      // Why?
      // AuthGate is listening to authStateChanges
      // Once signup completes, user is logged in
      // AuthGate will automatically route the user
      // to the correct dashboard based on role
    } catch (error) {
      // STEP 4: Error handling
      // Any Firebase/Auth/Firestore error will be shown safely
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  /// -------------------------------------------------------
  /// UI BUILD METHOD
  /// -------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Top app bar
      appBar: AppBar(
        title: const Text('Create Account'),
      ),

      /// Main body
      body: Padding(
        padding: const EdgeInsets.all(16),

        /// Column layout for form fields
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// ------------------------------------------------
            /// EMAIL INPUT FIELD
            /// ------------------------------------------------
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),

            const SizedBox(height: 12),

            /// ------------------------------------------------
            /// PASSWORD INPUT FIELD
            /// ------------------------------------------------
            TextField(
              controller: _passwordController,
              obscureText: true, // hides password
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),

            const SizedBox(height: 20),

            /// ------------------------------------------------
            /// ROLE SELECTION DROPDOWN
            /// ------------------------------------------------
            /// This is the MOST IMPORTANT FIELD
            /// Role decides:
            /// - Which dashboard user sees
            /// - What permissions they have
            /// - What data they can access
            DropdownButtonFormField<UserRole>(
              value: _selectedRole,
              hint: const Text('Select Role'),

              /// Create dropdown items from enum values
              items: UserRole.values.map((role) {
                return DropdownMenuItem<UserRole>(
                  value: role,
                  child: Text(role.name.toUpperCase()),
                );
              }).toList(),

              /// Update selected role in state
              onChanged: (role) {
                setState(() {
                  _selectedRole = role;
                });
              },
            ),

            const SizedBox(height: 30),

            /// ------------------------------------------------
            /// SIGNUP BUTTON
            /// ------------------------------------------------
            ElevatedButton(
              onPressed: _signup,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}