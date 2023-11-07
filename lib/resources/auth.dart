// ignore_for_file: avoid_print
import 'dart:developer' as l;
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart';
import 'package:juridentt/client/clientsearchpage.dart';
import 'package:juridentt/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get currentUser => auth.currentUser;

  // User Registration for lawyer
  Future<String> lawyerregisterUser({
    required String profile,
    required String name,
    required String location,
    required String lawyerId,
    required String clientId,
    required String mobileNumber,
    required String email,
    required String address,
    required String type,
    required String password,
  }) async {
    String resp = 'Some Error Occurred';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String? mtoken = await FirebaseMessaging.instance.getToken();
      Info userData = Info(
        profile: profile,
        name: name,
        location: location,
        lawyerId: lawyerId,
        clientId: clientId,
        mobileNumber: mobileNumber,
        email: email,
        address: address,
        type: type,
        mtoken: mtoken.toString(),
      );

      await firestore
          .collection('lawyers')
          .doc(userCredential.user!.uid)
          .set(userData.toJson());

      // create a lawyer Id with 5 digit random number and update the lawyerId field
      String generateLawyerId() {
        var random = Random();
        var codeUnits = List.generate(5, (index) {
          return random.nextInt(9) + 1;
        });
        return codeUnits.join();
      }

      String lawyerId1 = generateLawyerId();
      await firestore
          .collection('lawyers')
          .doc(userCredential.user!.uid)
          .update({'lawyerId': lawyerId1});

      resp = 'success';
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          resp =
              'The provided password is too weak. Please choose a stronger password.';
        } else if (e.code == 'email-already-in-use') {
          resp =
              'The account already exists for that email. Please try creating a new account.';
        } else {
          resp = e.message ?? 'Some Error Occurred';
        }
      } else {
        resp = e.toString();
      }
    }
    return resp;
  }

  // User Registration for client
  Future<String> clientregisterUser({
    required String profile,
    required String name,
    required String location,
    required String lawyerId,
    required String clientId,
    required String mobileNumber,
    required String email,
    required String address,
    required String type,
    required String password,
  }) async {
    String resp = 'Some Error Occurred';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String? mtoken = await FirebaseMessaging.instance.getToken();
      Info userData = Info(
        profile: profile,
        name: name,
        location: location,
        lawyerId: lawyerId,
        clientId: clientId,
        mobileNumber: mobileNumber,
        email: email,
        address: address,
        type: type,
        mtoken: mtoken.toString(),
      );

      await firestore
          .collection('client')
          .doc(userCredential.user!.uid)
          .set(userData.toJson());

      // create a lawyer Id with 5 digit random number and update the lawyerId field
      String generateLawyerId() {
        var random = Random();
        var codeUnits = List.generate(5, (index) {
          return random.nextInt(9) + 1;
        });
        return codeUnits.join();
      }

      String clientId1 = generateLawyerId();
      await firestore
          .collection('client')
          .doc(userCredential.user!.uid)
          .update({'clientId': clientId1});

      resp = 'success';
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          resp =
              'The provided password is too weak. Please choose a stronger password.';
        } else if (e.code == 'email-already-in-use') {
          resp =
              'The account already exists for that email. Please try creating a new account.';
        } else {
          resp = e.message ?? 'Some Error Occurred';
        }
      } else {
        resp = e.toString();
      }
    }
    return resp;
  }

  // User Login for Lawyers
  Future<String> lawyerloginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some Error Occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
        final sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        sharedPreferences.setString('userType', 'lawyer');
      } else {
        res = 'Please enter email and password';
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          res = 'Incorrect password. Please try again.';
        } else if (e.code == 'user-not-found') {
          res = 'User not found. Please create a new account.';
        } else {
          res = e.message ?? 'Some Error Occurred';
        }
      } else {
        res = e.toString();
      }
    }
    return res;
  }

  // User Login for Client
  Future<String> clientloginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some Error Occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
        final sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        sharedPreferences.setString('userType', 'client');
      } else {
        res = 'Please enter email and password';
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          res = 'Incorrect password. Please try again.';
        } else if (e.code == 'user-not-found') {
          res = 'User not found. Please create a new account.';
        } else {
          res = e.message ?? 'Some Error Occurred';
        }
      } else {
        res = e.toString();
      }
    }
    return res;
  }

  // User Logout
  Future signOut() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      return await auth.signOut();
      // You can navigate to a different screen or perform any other actions here
    } catch (err) {
      SnackBar(content: Text(err.toString()));
      return null;
    }
  }

  // Get User Data
  Future<Info> getUserData() async {
    User currentUser = auth.currentUser!;
    DocumentSnapshot snap =
        await firestore.collection('lawyers').doc(currentUser.uid).get();
    return Info.fromDocumentSnapshot(snap);
  }

  // Check Login Status
  Future<bool> checkLoginStatus() async {
    return auth.currentUser != null;
  }

  // User Stream
  Stream<User?> currentUserStream() {
    return auth.authStateChanges();
  }

  // SignIn/Up with google for lawyers
  // signInWithGoogleLawyer(context) async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     if (googleUser != null) {
  //       // Obtain the auth details from the request
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       // Create a new credential
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );

  //       // Sign in with the credential
  //       final UserCredential userCredentials =
  //           await FirebaseAuth.instance.signInWithCredential(credential);

  //       // Get the user details
  //       final User? user = userCredentials.user;

  //       if (user != null) {
  //         // Check if the user exists in Firestore
  //         final userDoc =
  //             FirebaseFirestore.instance.collection('lawyers').doc(user.uid);

  //         final userDocSnapshot = await userDoc.get();
  //         final sharedPreferences = await SharedPreferences.getInstance();
  //         await sharedPreferences.clear();
  //         sharedPreferences.setString('userType', 'lawyer');

  //         if (userDocSnapshot.exists) {
  //           await userDoc.update({
  //             'name': user.displayName,
  //           });

  //           // Push to the home page
  //           Navigator.pushNamed(context, '/lawyerhomescreen');
  //         } else {
  //           String? mtoken = await FirebaseMessaging.instance.getToken();

  //           Info userData = Info(
  //             profile: '',
  //             name: user.displayName.toString(),
  //             location: '',
  //             lawyerId: '',
  //             clientId: '',
  //             mobileNumber: '',
  //             email: user.email.toString(),
  //             address: '',
  //             type: '',
  //             mtoken: mtoken.toString(),
  //           );

  //           await firestore
  //               .collection('lawyers')
  //               .doc(userCredentials.user!.uid)
  //               .set(userData.toJson());

  //           // create a lawyer Id with 5 digit random number and update the lawyerId field
  //           String generateLawyerId() {
  //             var random = Random();
  //             var codeUnits = List.generate(5, (index) {
  //               return random.nextInt(9) + 1;
  //             });
  //             return codeUnits.join();
  //           }

  //           String lawyerId1 = generateLawyerId();
  //           await firestore
  //               .collection('lawyers')
  //               .doc(user.uid)
  //               .update({'lawyerId': lawyerId1});

  //           // Push to the home page
  //           // Navigator.pushNamed(context, '/homescreen');

  //           // Push to the phone verification page
  //           Navigator.pushNamed(context, '/lawyerphonenumberinput');
  //         }
  //       } else {
  //         AlertDialog(
  //           title: const Text('Error'),
  //           content: const SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text(
  //                   'Error signing in with Google.',
  //                 ),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('Ok'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'account-exists-with-different-credential') {
  //       AlertDialog(
  //         title: const Text('Error'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(
  //                 'An account with a different sign-in method already exists for the same email address.',
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     } else if (e.code == 'invalid-credential') {
  //       AlertDialog(
  //         title: const Text('Error'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(
  //                 'The supplied auth credential is malformed or has expired.',
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     } else {
  //       AlertDialog(
  //         title: const Text('Error'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('An error occurred while signing in with Google.'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     }
  //   } catch (e) {
  //     AlertDialog(
  //       title: const Text('Error'),
  //       content: const SingleChildScrollView(
  //         child: ListBody(
  //           children: <Widget>[
  //             Text('An error occurred while signing in with Google.'),
  //           ],
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text('Ok'),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       ],
  //     );
  //   }
  // }

  signInWithGoogleLawyer(context) async {
    try {
      l.log('google sign in clicked');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Sign in with the credential
      final UserCredential userCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the user details
      final User? user = userCredentials.user;
      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('lawyers').doc(user.uid);
        final userDocSnapshot = await userDoc.get();
        final bool userDocExists = userDocSnapshot.exists;
        final Map<String, dynamic>? userData = userDocExists
            ? userDocSnapshot.data() as Map<String, dynamic>
            : null;
        final String? mobileNumber = userData?['mobileNumber'];
        print('the mobile is $mobileNumber');

        final sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        sharedPreferences.setString('userType', 'lawyer');

        if (userDocSnapshot.exists) {
          await userDoc.update({'name': user.displayName});

          // if (mobileNumber != null || mobileNumber != '') {
          //   Navigator.pushNamed(context, '/lawyerhomescreen');
          // } else {
          //   Navigator.pushNamed(context, '/lawyerphonenumberinput');
          // }
          if (mobileNumber == null || mobileNumber == '') {
            Navigator.pushNamed(context, '/lawyerphonenumberinput');
          } else {
            Navigator.pushNamed(context, '/lawyerhomescreen');
          }
        } else {
          String? mtoken = await FirebaseMessaging.instance.getToken();
          Info userData = Info(
            profile: '',
            name: user.displayName.toString(),
            location: '',
            lawyerId: '',
            clientId: '',
            mobileNumber: '',
            email: user.email.toString(),
            address: '',
            type: '',
            mtoken: mtoken.toString(),
          );

          await firestore
              .collection('lawyers')
              .doc(userCredentials.user!.uid)
              .set(userData.toJson());

          String generateLawyerId() {
            var random = Random();
            var codeUnits = List.generate(5, (index) {
              return random.nextInt(9) + 1;
            });
            return codeUnits.join();
          }

          String lawyerId1 = generateLawyerId();
          await firestore
              .collection('lawyers')
              .doc(user.uid)
              .update({'lawyerId': lawyerId1});

          Navigator.pushNamed(context, '/lawyerphonenumberinput');
        }
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Error signing in with Google.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An account with a different sign-in method already exists for the same email address.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else if (e.code == 'invalid-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'The supplied auth credential is malformed or has expired.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An error occurred while signing in with Google.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('An error occurred while signing in with Google.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  // SignIn/Up with google for client
  // signInWithGoogleClient(context) async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     if (googleUser != null) {
  //       // Obtain the auth details from the request
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       // Create a new credential
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );

  //       // Sign in with the credential
  //       final UserCredential userCredentials =
  //           await FirebaseAuth.instance.signInWithCredential(credential);

  //       // Get the user details
  //       final User? user = userCredentials.user;

  //       final sharedPreferences = await SharedPreferences.getInstance();
  //       await sharedPreferences.clear();
  //       sharedPreferences.setString('userType', 'client');

  //       if (user != null) {
  //         // Check if the user exists in Firestore
  //         final userDoc =
  //             FirebaseFirestore.instance.collection('client').doc(user.uid);

  //         final userDocSnapshot = await userDoc.get();

  //         if (userDocSnapshot.exists) {
  //           await userDoc.update({
  //             'name': user.displayName,
  //           });

  //           // Push to the home page
  //           Navigator.pushNamed(context, '/clienthomescreen');
  //         } else {
  //           String? mtoken = await FirebaseMessaging.instance.getToken();

  //           Info userData = Info(
  //             profile: '',
  //             name: user.displayName.toString(),
  //             location: '',
  //             lawyerId: '',
  //             clientId: '',
  //             mobileNumber: '',
  //             email: user.email.toString(),
  //             address: '',
  //             type: '',
  //             mtoken: mtoken.toString(),
  //           );

  //           await firestore
  //               .collection('client')
  //               .doc(userCredentials.user!.uid)
  //               .set(userData.toJson());

  //           // create a lawyer Id with 5 digit random number and update the lawyerId field
  //           String generateLawyerId() {
  //             var random = Random();
  //             var codeUnits = List.generate(5, (index) {
  //               return random.nextInt(9) + 1;
  //             });
  //             return codeUnits.join();
  //           }

  //           String clientId1 = generateLawyerId();
  //           await firestore
  //               .collection('client')
  //               .doc(user.uid)
  //               .update({'clientId': clientId1});

  //           // Push to the home page
  //           // Navigator.pushNamed(context, '/homescreen');

  //           // Push to the phone verification page
  //           Navigator.pushNamed(context, '/clientphonenumberinput');
  //         }
  //       } else {
  //         AlertDialog(
  //           title: const Text('Error'),
  //           content: const SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text(
  //                   'Error signing in with Google.',
  //                 ),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('Ok'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'account-exists-with-different-credential') {
  //       AlertDialog(
  //         title: const Text('Error'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(
  //                 'An account with a different sign-in method already exists for the same email address.',
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     } else if (e.code == 'invalid-credential') {
  //       AlertDialog(
  //         title: const Text('Error'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(
  //                 'The supplied auth credential is malformed or has expired.',
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     } else {
  //       AlertDialog(
  //         title: const Text('Error'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('An error occurred while signing in with Google.'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     }
  //   } catch (e) {
  //     AlertDialog(
  //       title: const Text('Error'),
  //       content: const SingleChildScrollView(
  //         child: ListBody(
  //           children: <Widget>[
  //             Text('An error occurred while signing in with Google.'),
  //           ],
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text('Ok'),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       ],
  //     );
  //   }
  // }

  signInWithGoogleClient(context) async {
    try {
      l.log('pressed');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in with the credential
      final UserCredential userCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the user details
      final User? user = userCredentials.user;

      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('client').doc(user.uid);
        final userDocSnapshot = await userDoc.get();
        final bool userDocExists = userDocSnapshot.exists;
        final Map<String, dynamic>? userData = userDocExists
            ? userDocSnapshot.data() as Map<String, dynamic>
            : null;
        final String? mobileNumber = userData?['mobileNumber'];

        final sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        sharedPreferences.setString('userType', 'client');

        if (userDocExists) {
          await userDoc.update({'name': user.displayName});

          if (mobileNumber != null || mobileNumber != '') {

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HomePage();
            },));

          } else {
            Navigator.pushNamed(context, '/clientphonenumberinput');
          }
        } else {
          String? mtoken = await FirebaseMessaging.instance.getToken();

          Info userData = Info(
            profile: '',
            name: user.displayName.toString(),
            location: '',
            lawyerId: '',
            clientId: '',
            mobileNumber: '',
            email: user.email.toString(),
            address: '',
            type: '',
            mtoken: mtoken.toString(),
          );

          await firestore
              .collection('client')
              .doc(userCredentials.user!.uid)
              .set(userData.toJson());

          String generateClientId() {
            var random = Random();
            var codeUnits = List.generate(5, (index) {
              return random.nextInt(9) + 1;
            });
            return codeUnits.join();
          }

          String clientId1 = generateClientId();
          await firestore
              .collection('client')
              .doc(user.uid)
              .update({'clientId': clientId1});

          Navigator.pushNamed(context, '/clientphonenumberinput');
        }
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Error signing in with Google.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An account with a different sign-in method already exists for the same email address.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else if (e.code == 'invalid-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'The supplied auth credential is malformed or has expired.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An error occurred while signing in with Google.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('An error occurred while signing in with Google.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  // SignIn/Up with Facebook for lawyers
  signInWithFacebookLawyer(context) async {
    try {
      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential usercredentials = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      // Get the user details
      User? user = usercredentials.user;

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      sharedPreferences.setString('userType', 'lawyer');

      if (user != null) {
        // Check if the user exists in Firestore
        final userDoc =
            FirebaseFirestore.instance.collection('lawyers').doc(user.uid);

        final userDocSnapshot = await userDoc.get();

        if (userDocSnapshot.exists) {
          await userDoc.update({
            'name': user.displayName,
            // 'email': user.email,
          });

          // Push to the home page
          Navigator.pushNamed(context, '/lawyerhomescreen');
        } else {
          String? mtoken = await FirebaseMessaging.instance.getToken();

          Info userData = Info(
            profile: '',
            name: user.displayName.toString(),
            location: '',
            lawyerId: '',
            clientId: '',
            mobileNumber: '',
            email: user.email.toString(),
            address: '',
            type: '',
            mtoken: mtoken.toString(),
          );

          await firestore
              .collection('lawyers')
              .doc(usercredentials.user!.uid)
              .set(userData.toJson());

          // Push to the home page
          Navigator.pushNamed(context, '/lawyerhomescreen');
        }
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Error signing in with Facebook.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An account with a different sign-in method already exists for the same email address.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else if (e.code == 'invalid-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'The supplied auth credential is malformed or has expired.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An error occurred while signing in with Facebook.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('An error occurred while signing in with Facebook.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  // SignIn/Up with Facebook for Client
  signInWithFacebookClient(context) async {
    try {
      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential usercredentials = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      // Get the user details
      User? user = usercredentials.user;

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      sharedPreferences.setString('userType', 'client');

      if (user != null) {
        // Check if the user exists in Firestore
        final userDoc =
            FirebaseFirestore.instance.collection('client').doc(user.uid);

        final userDocSnapshot = await userDoc.get();

        if (userDocSnapshot.exists) {
          await userDoc.update({
            'name': user.displayName,
            // 'email': user.email,
          });

          // Push to the home page
          Navigator.pushNamed(context, '/clienthomescreen');
        } else {
          String? mtoken = await FirebaseMessaging.instance.getToken();

          Info userData = Info(
            profile: '',
            name: user.displayName.toString(),
            location: '',
            lawyerId: '',
            clientId: '',
            mobileNumber: '',
            email: user.email.toString(),
            address: '',
            type: '',
            mtoken: mtoken.toString(),
          );

          await firestore
              .collection('client')
              .doc(usercredentials.user!.uid)
              .set(userData.toJson());

          // Push to the home page
          Navigator.pushNamed(context, '/clienthomescreen');
        }
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Error signing in with Facebook.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An account with a different sign-in method already exists for the same email address.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else if (e.code == 'invalid-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'The supplied auth credential is malformed or has expired.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An error occurred while signing in with Facebook.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('An error occurred while signing in with Facebook.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  // SignIn/Up with Twitter for lawyers
  signInWithTwitterLawyer(context) async {
    try {
      // Create a TwitterLogin instance
      final twitterLogin = TwitterLogin(
        apiKey: 'b0lpIeElpGI9V1Mtaiv4iNHEs',
        apiSecretKey: 'LPWlbWCccYVmgrdUiHcJ475TCTCM7seinPAF1JnxHwPnsCxds1',
        redirectURI: 'https://jurident-9a928.firebaseapp.com/__/auth/handler',
      );

      // Trigger the sign-in flow
      final authResult = await twitterLogin.login();

      // Create a credential from the access token
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      // Once signed in, return the UserCredential
      UserCredential usercredentials = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);

      // Get the user details
      User? user = usercredentials.user;

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      sharedPreferences.setString('userType', 'lawyer');

      if (user != null) {
        // Check if the user exists in Firestore
        final userDoc =
            FirebaseFirestore.instance.collection('lawyers').doc(user.uid);

        final userDocSnapshot = await userDoc.get();

        if (userDocSnapshot.exists) {
          await userDoc.update({
            'name': user.displayName,
            // 'email': user.email,
          });

          // Push to the home page
          Navigator.pushNamed(context, '/lawyerhomescreen');
        } else {
          String? mtoken = await FirebaseMessaging.instance.getToken();

          Info userData = Info(
            profile: '',
            name: user.displayName.toString(),
            location: '',
            lawyerId: '',
            clientId: '',
            mobileNumber: '',
            email: user.email.toString(),
            address: '',
            type: '',
            mtoken: mtoken.toString(),
          );

          await firestore
              .collection('lawyers')
              .doc(usercredentials.user!.uid)
              .set(userData.toJson());

          // Push to the home page
          Navigator.pushNamed(context, '/lawyerhomescreen');
        }
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Error signing in with Facebook.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An account with a different sign-in method already exists for the same email address.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else if (e.code == 'invalid-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'The supplied auth credential is malformed or has expired.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An error occurred while signing in with Twitter.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('An error occurred while signing in with Twitter.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  // SignIn/Up with Twitter for client
  signInWithTwitterClients(context) async {
    try {
      // Create a TwitterLogin instance
      final twitterLogin = TwitterLogin(
        apiKey: 'b0lpIeElpGI9V1Mtaiv4iNHEs',
        apiSecretKey: 'LPWlbWCccYVmgrdUiHcJ475TCTCM7seinPAF1JnxHwPnsCxds1',
        redirectURI: 'https://jurident-9a928.firebaseapp.com/__/auth/handler',
      );

      // Trigger the sign-in flow
      final authResult = await twitterLogin.login();

      // Create a credential from the access token
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      // Once signed in, return the UserCredential
      UserCredential usercredentials = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);

      // Get the user details
      User? user = usercredentials.user;

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      sharedPreferences.setString('userType', 'client');

      if (user != null) {
        // Check if the user exists in Firestore
        final userDoc =
            FirebaseFirestore.instance.collection('client').doc(user.uid);

        final userDocSnapshot = await userDoc.get();

        if (userDocSnapshot.exists) {
          await userDoc.update({
            'name': user.displayName,
            // 'email': user.email,
          });

          // Push to the home page
          Navigator.pushNamed(context, '/clienthomescreen');
        } else {
          String? mtoken = await FirebaseMessaging.instance.getToken();

          Info userData = Info(
            profile: '',
            name: user.displayName.toString(),
            location: '',
            lawyerId: '',
            clientId: '',
            mobileNumber: '',
            email: user.email.toString(),
            address: '',
            type: '',
            mtoken: mtoken.toString(),
          );

          await firestore
              .collection('client')
              .doc(usercredentials.user!.uid)
              .set(userData.toJson());

          // Push to the home page
          Navigator.pushNamed(context, '/clienthomescreen');
        }
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Error signing in with Twitter.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An account with a different sign-in method already exists for the same email address.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else if (e.code == 'invalid-credential') {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'The supplied auth credential is malformed or has expired.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else {
        AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An error occurred while signing in with Twitter.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('An error occurred while signing in with Twitter.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  // Reset Password with email link.
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  // Update User phone number for lawyers
  Future<String> updatePhoneNumberLawyer({
    required String phoneNumber,
  }) async {
    String res = 'Some Error Occurred';
    try {
      if (phoneNumber.isNotEmpty) {
        User currentUser = auth.currentUser!;
        await firestore
            .collection('lawyers')
            .doc(currentUser.uid)
            .update({'mobileNumber': phoneNumber});
        res = 'success';
        final sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        sharedPreferences.setString('userType', 'lawyer');
      } else {
        res = 'Please enter your mobile number';
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        res = e.message ?? 'Some Error Occurred';
      } else {
        res = e.toString();
      }
    }
    return res;
  }

// Update User phone number for Client
  Future<String> updatePhoneNumberClient({
    required String phoneNumber,
  }) async {
    String res = 'Some Error Occurred';
    try {
      if (phoneNumber.isNotEmpty) {
        User currentUser = auth.currentUser!;
        await firestore
            .collection('client')
            .doc(currentUser.uid)
            .update({'mobileNumber': phoneNumber});
        res = 'success';
        final sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        sharedPreferences.setString('userType', 'client');
      } else {
        res = 'Please enter your mobile number';
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        res = e.message ?? 'Some Error Occurred';
      } else {
        res = e.toString();
      }
    }
    return res;
  }
}
