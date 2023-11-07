import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserDetail {
  final String id;
  final String displayName;
  final String email;
  // Add other properties as needed

  UserDetail({
    required this.id,
    required this.displayName,
    required this.email,
    // Initialize other properties in the constructor
  });
}

class UserDetailProvider with ChangeNotifier {
  UserDetail? _userDetail;

  UserDetail? get userDetail => _userDetail;

  Future<void> fetchUserDetail() async {
    // Check if user details are already fetched
    if (_userDetail != null) {
      return;
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        _userDetail = null;
        notifyListeners();
        return;
      }

      final userCollection = FirebaseFirestore.instance.collection('lawyers');
      final userDoc = await userCollection.doc(currentUser.uid).get();

      if (userDoc.exists) {
        _userDetail = UserDetail(
          id: currentUser.uid,
          displayName: userDoc['name'],
          email: userDoc['email'],
          // Map other fields from the document to properties in UserDetail class
        );
      } else {
        // Handle the case where the user document does not exist
        // For example, you can create a new document for the user here
      }

      notifyListeners();
    } catch (error) {
      print("Error fetching user details: $error");
    }
  }
}
