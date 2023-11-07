// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class EmailOTP {

//   final _auth=FirebaseAuth.instance;



//   verifyPhone(String phoneNumber){


//     try {
//     await  _auth.verifyPhoneNumber(
//       phoneNumber: '+91$phoneNumber',
//         verificationCompleted: (phoneAuthCredential) {
//         },
//         verificationFailed: (error) {
//         },
//         codeSent: (verificationId, forceResendingToken) {
//           authController.toogleloading();
//           Navigator.of(context).push(
//             PageRouteBuilder(
//                 opaque: false,
//                 pageBuilder: (_, __, ___) {
//                   return VerifyOTP(
//                       countrycode: "$countrycode - $phoneNumber",
//                       verificationid: verificationId
//                       );
//                 }),
//           );
//         },
//         codeAutoRetrievalTimeout: (verificationId) {
//           authController.toogleloading();
//         },
//       ).onError((error, stackTrace) => print(error));
//     } on FirebaseAuthException catch (e) {
//       print('yes');
//       log(e.message!);
//       authController.toogleloading();
//       Get.rawSnackbar(
//         backgroundColor: Colors.red,
//         messageText:const Text('Something went wrong!')
//       );
//     }

//   }
  
// }