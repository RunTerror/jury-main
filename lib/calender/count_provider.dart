//
//
//
// ////  done delete bala part tk shi kaam kr rha hai, done ko store krni ki prblm hai
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
//
// class CountProvider with ChangeNotifier {
//   int _count = 0;
//   List<bool> _isCheckIconVisibleList = [];
//
//   int get count => _count;
//   List<bool> get isCheckIconVisibleList => _isCheckIconVisibleList;
//
//   void incrementCount() {
//     _count++;
//     notifyListeners();
//   }
//   void decrementCount() {
//     _count--;
//     notifyListeners();
//   }
//   void initializeVisibilityList(int length) {
//     _isCheckIconVisibleList = List<bool>.generate(length, (index) => true);
//     notifyListeners();
//   }
//
//   void toggleVisibility(int index) {
//     _isCheckIconVisibleList[index] = !_isCheckIconVisibleList[index];
//     notifyListeners();
//   }
//
//   Stream<int> getTotalCountStream() {
//     String today = DateTime.now().toIso8601String().substring(0, 10);
//
//     return FirebaseFirestore.instance
//         .collection('users')
//         .where('date', isEqualTo: today)
//         .snapshots()
//         .map((snapshot) => snapshot.size);
//   }
//
//   Stream<int> getCountStream() {
//     String today = DateTime.now().toIso8601String().substring(0, 10);
//
//     return FirebaseFirestore.instance
//         .collection('doneschedule')
//         .where('date', isEqualTo: today)
//         .snapshots()
//         .map((snapshot) => snapshot.size);
//   }
//
//
// }
//
//
//
//
// // import 'dart:async';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class CountProvider with ChangeNotifier {
// //   int _count = 0;
// //   List<bool> _isCheckIconVisibleList = [];
// //
// //   int get count => _count;
// //   List<bool> get isCheckIconVisibleList => _isCheckIconVisibleList;
// //
// //   Future<void> incrementCount() async {
// //     _count++;
// //     notifyListeners();
// //   }
// //
// //   Future<void> decrementCount() async {
// //     _count--;
// //     notifyListeners();
// //   }
// //
//
// //
// //   Future<void> initializeVisibilityList(int length) async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     if (prefs.containsKey('checkIconVisibility')) {
// //       // Load the saved visibility state from shared preferences
// //       List<String> visibilityStringList = prefs.getStringList('checkIconVisibility') ?? [];
// //       _isCheckIconVisibleList = List<bool>.generate(length, (index) {
// //         if (index < visibilityStringList.length) {
// //           return visibilityStringList[index] == 'true';
// //         } else {
// //           return true;
// //         }
// //       });
// //     } else {
// //       // Initialize the visibility list with default values
// //       _isCheckIconVisibleList = List<bool>.generate(length, (index) => true);
// //     }
// //     notifyListeners();
// //   }
// //
// //
// //   Future<void> toggleVisibility(int index) async {
// //     _isCheckIconVisibleList[index] = !_isCheckIconVisibleList[index];
// //
// //     // Save the updated visibility state to shared preferences
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     List<String> visibilityStringList = _isCheckIconVisibleList.map((visible) => visible.toString()).toList();
// //     await prefs.setStringList('checkIconVisibility', visibilityStringList);
// //
// //     notifyListeners();
// //   }
// //
// //   Stream<int> getTotalCountStream() {
// //     String today = DateTime.now().toIso8601String().substring(0, 10);
// //
// //     return FirebaseFirestore.instance
// //         .collection('users')
// //         .where('date', isEqualTo: today)
// //         .snapshots()
// //         .map((snapshot) => snapshot.size);
// //   }
// // }
//



import 'dart:async';
// import 'dart:js';
// import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../provider1.dart';

class CountProvider with ChangeNotifier {
  int _count = 0;
  List<bool> _isCheckIconVisibleList = [];
  late BuildContext _context;

  int get count => _count;
  List<bool> get isCheckIconVisibleList => _isCheckIconVisibleList;
  // String currentUserMobileNumber = Provider.of<UserProvider>(context as BuildContext , listen: false).user.mobileNumber;

  void setContext(BuildContext context) {
    _context = context;
  }

  void incrementCount() {
    _count++;
    notifyListeners();
  }
  void decrementCount() {
    _count--;
    notifyListeners();
  }
  void initializeVisibilityList(int length) {
    // _isCheckIconVisibleList = List<bool>.generate(length, (index) => true);
    // notifyListeners();
    //for removing the error of the setState() and marksNeedBuild()  called during build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isCheckIconVisibleList = List<bool>.generate(length, (index) => true);
      notifyListeners();
    });
  }

  void toggleVisibility(int index) {
    _isCheckIconVisibleList[index] = !_isCheckIconVisibleList[index];
    notifyListeners();
  }

  Stream<int> getTotalCountStream() {
    String today = DateTime.now().toIso8601String().substring(0, 10);
    String currentUserMobileNumber =
        Provider.of<UserProvider>(_context, listen: false).user.mobileNumber;

    return FirebaseFirestore.instance
        .collection('events')
        .where('date', isEqualTo: today)
        .where('mobile', isEqualTo: currentUserMobileNumber)
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Stream<int> getCountStream() {
    String today = DateTime.now().toIso8601String().substring(0, 10);
    String currentUserMobileNumber =
        Provider.of<UserProvider>(_context, listen: false).user.mobileNumber;


    return FirebaseFirestore.instance
        .collection('doneschedule')
        .where('date', isEqualTo: today)
        .where('mobile', isEqualTo: currentUserMobileNumber)
        .snapshots()
        .map((snapshot) => snapshot.size);
  }


}







