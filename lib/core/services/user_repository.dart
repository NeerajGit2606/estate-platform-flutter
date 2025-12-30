// Imports Cloud Firestore package for database operations
import 'package:cloud_firestore/cloud_firestore.dart';

// Imports the UserRole enum used for role-based access
import '../../shared/enums/user_role.dart';

// Repository class responsible for all user-related Firestore operations
class UserRepository {

  // Creates a private instance of FirebaseFirestore
  // Used to interact with Firestore database
  final _db = FirebaseFirestore.instance;

  // Name of the Firestore collection where users are stored
  final _collection = 'users';

  // Method to create a new user document in Firestore
  // This is usually called after successful Firebase Authentication signup
  Future<void> createUser({
    required String uid,       // Unique user ID from Firebase Auth
    required String email,     // User email address
    required UserRole role,    // User role (buyer, seller, agent, owner)
  }) {
    // Creates or overwrites a document with document ID = uid
    return _db.collection(_collection).doc(uid).set({
      'email': email,                          // Stores user email
      'role': role.name,                      // Stores enum name as string
      'createdAt': FieldValue.serverTimestamp(), // Server-side timestamp
    });
  }

  // Method to fetch the role of a user from Firestore
  // Returns null if the user document does not exist
  Future<UserRole?> getUserRole(String uid) async {

    // Fetches the user document using UID
    final doc = await _db.collection(_collection).doc(uid).get();

    // If document does not exist, return null
    if (!doc.exists) return null;

    // Extracts role value stored as string from Firestore document
    final roleName = doc.data()!['role'];

    // Converts stored string back into UserRole enum
    return UserRole.values.firstWhere(
      (e) => e.name == roleName,
    );
  }
}
