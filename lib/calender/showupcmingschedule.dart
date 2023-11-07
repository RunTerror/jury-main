// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'calendar.dart';
// import 'package:intl/intl.dart';
//
// class Addschedule extends StatefulWidget {
//   const Addschedule({Key? key}) : super(key: key);
//
//   @override
//   State<Addschedule> createState() => _AddscheduleState();
// }
//
// class _AddscheduleState extends State<Addschedule> {
//
//
//   CollectionReference<Map<String, dynamic>> collectionRef = FirebaseFirestore.instance.collection('users');
//
//   Widget listItem({required DocumentSnapshot<Map<String, dynamic>> document}) {
//     Map<String, dynamic> student = document.data()!;
//
//     return Container(
//       margin: const EdgeInsets.all(15),
//       padding: const EdgeInsets.all(15),
//       height: 80,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Color(0xFFC99F4A)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             children: [
//               Text(
//                 student['name'],
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xFFC99F4A),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Row(
//                 children: [
//                   SizedBox(width: 10),
//                   Text(
//                     student['date'],
//                     style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
//                   ),
//                   SizedBox(width: 5),
//                   Text(
//                     student['time'],
//                     style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(width: 175),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   document.reference.delete();
//                 },
//                 child: Row(
//                   children: const [
//                     Icon(
//                       Icons.delete,
//                       color: Color(0xFFC99F4A),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           SizedBox(height: 20),
//           Container(
//             height: 600,
//             child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//               stream: collectionRef.snapshots(),
//               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }
//
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
//                 }
//
//                 // Get the current date
//                 DateTime currentDate = DateTime.now();
//                 String currentDateString = DateFormat('yyyy-MM-dd').format(currentDate);
//
//                 // Filter the documents based on the date condition
//                 List<DocumentSnapshot<Map<String, dynamic>>> filteredDocuments = snapshot.data!.docs.where((document) {
//                   // Get the fetched date from the document data
//                   String fetchedDate = document!.data()['date'];
//
//                   // Parse the fetched date string into a DateTime object
//                   DateTime fetchedDateTime = DateTime.parse(fetchedDate);
//
//                   // Format the fetched date as a string
//                   String fetchedDateString = DateFormat('yyyy-MM-dd').format(fetchedDateTime);
//
//                   // Compare the fetched date with the current date
//                   return fetchedDateString != currentDateString;
//                 }).toList();
//
//                 return ListView.builder(
//                   itemCount: filteredDocuments.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     DocumentSnapshot<Map<String, dynamic>> document = filteredDocuments[index];
//                     return listItem(document: document);
//                   },
//                 );
//               },
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../provider1.dart';
import 'package:intl/intl.dart';

class Addschedule extends StatefulWidget {
  const Addschedule({Key? key}) : super(key: key);

  @override
  State<Addschedule> createState() => _AddscheduleState();
}

class _AddscheduleState extends State<Addschedule> {
  CollectionReference<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection('events');

  Widget listItem({required DocumentSnapshot<Map<String, dynamic>> document}) {
    Map<String, dynamic> student = document.data()!;

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC99F4A)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                student['title'],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFC99F4A),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  SizedBox(width: 10.w),
                  Text(
                    student['date'],
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    student['time'],
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 175.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  document.reference.delete();
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Color(0xFFC99F4A),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserMobileNumber =
        Provider.of<UserProvider>(context, listen: false).user.mobileNumber;

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 20.h),
          SizedBox(
            height: 600.h,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: collectionRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                }

                // Get the current date
                DateTime currentDate = DateTime.now();
                String currentDateString =
                    DateFormat('yyyy-MM-dd').format(currentDate);

                // Filter the documents based on the date condition
                List<DocumentSnapshot<Map<String, dynamic>>> filteredDocuments =
                    snapshot.data!.docs.where((document) {
                  // Get the fetched date from the document data
                  String fetchedDate = document.data()['date'];
                  String fetchedMobileNumber = document.data()['mobile'];

                  // Parse the fetched date string into a DateTime object
                  DateTime fetchedDateTime = DateTime.parse(fetchedDate);

                  // Format the fetched date as a string
                  String fetchedDateString =
                      DateFormat('yyyy-MM-dd').format(fetchedDateTime);

                  // Compare the fetched date with the current date
                  return fetchedDateString != currentDateString &&
                      fetchedMobileNumber == currentUserMobileNumber;
                }).toList();

                return ListView.builder(
                  itemCount: filteredDocuments.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot<Map<String, dynamic>> document =
                        filteredDocuments[index];
                    return listItem(document: document);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
