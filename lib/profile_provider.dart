import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/models/user.dart';

class ProfileProvider extends ChangeNotifier {
  Info? _userInfo;
  Info? get userInfo => _userInfo;

  

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserdata() {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    print('called');
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('lawyers').doc(uid).snapshots();
  }
}
