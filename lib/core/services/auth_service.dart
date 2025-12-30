// Imports Firebase Authentication package
import 'package:firebase_auth/firebase_auth.dart';

// Service class responsible for all authentication-related operations
class AuthService {

  // Creates a private instance of FirebaseAuth
  // This is used to interact with Firebase Authentication APIs
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getter to retrieve the currently logged-in user
  // Returns null if no user is authenticated
  User? get currentUser => _auth.currentUser;

  // Stream that listens to authentication state changes
  // Emits a User object when logged in and null when logged out
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // Method to register a new user using email and password
  // Takes email and password as required parameters
  // Returns UserCredential containing user info on successful signup
  Future<UserCredential> signUp({
    required String email,     // User email for registration
    required String password,  // User password for registration
  }) {
    // Calls Firebase method to create a new user
    return _auth.createUserWithEmailAndPassword(
      email: email,           // Email passed to Firebase
      password: password,     // Password passed to Firebase
    );
  }

  // Method to sign in an existing user using email and password
  // Takes email and password as required parameters
  // Returns UserCredential on successful login
  Future<UserCredential> signIn({
    required String email,     // User email for login
    required String password,  // User password for login
  }) {
    // Calls Firebase method to authenticate the user
    return _auth.signInWithEmailAndPassword(
      email: email,           // Email passed to Firebase
      password: password,     // Password passed to Firebase
    );
  }

  // Method to sign out the currently logged-in user
  // Ends the Firebase authentication session
  Future<void> signOut() => _auth.signOut();
}
