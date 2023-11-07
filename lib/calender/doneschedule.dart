// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'addschedule.dart';
// import 'count_provider.dart';
//
// class DoneSchedule extends StatefulWidget {
//   const DoneSchedule({Key? key}) : super(key: key);
//
//   @override
//   State<DoneSchedule> createState() => _ScheduleState();
// }
// //
// class _ScheduleState extends State<DoneSchedule> {
//   CollectionReference<Map<String, dynamic>> collectionRef = FirebaseFirestore.instance.collection('doneschedule');
//
//   Widget listItem({required DocumentSnapshot<Map<String, dynamic>> document, required int index,required VoidCallback onCheckIconTap}) {
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
//                 style: const TextStyle(
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
//           const SizedBox(width: 80),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               GestureDetector(
//
//                 child: Row(
//                   children: const [
//
//                     SizedBox(width: 5),
//                     Visibility(
//                       // visible: !Provider.of<CountProvider>(context).isCheckIconVisibleList[index],
//                       child: Text(
//                         'Done',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//               ),
//             ],
//           ),
//
//           const SizedBox(width: 35),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   // Provider.of<CountProvider>(context, listen: false).decrementCount();
//                   if (!Provider.of<CountProvider>(context, listen: false).isCheckIconVisibleList[index]) {
//                     Provider.of<CountProvider>(context, listen: false).decrementCount();
//                   }
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
//   // void initializeCheckIconVisibility(int length) {
//   //   if (Provider.of<CountProvider>(context, listen: false).isCheckIconVisibleList.isEmpty) {
//   //     Provider.of<CountProvider>(context, listen: false).initializeVisibilityList(length);
//   //   }
//   // }
//   void initializeCheckIconVisibility(int length) {
//     if (Provider.of<CountProvider>(context, listen: false).isCheckIconVisibleList.length < length) {
//       Provider.of<CountProvider>(context, listen: false).initializeVisibilityList(length);
//     }
//   }
//   void _onCheckIconTap(DocumentSnapshot<Map<String, dynamic>> document) async {
//     Map<String, dynamic> student = document.data()!;
//
//     CollectionReference<Map<String, dynamic>> doneScheduleCollection = FirebaseFirestore.instance.collection('doneschedule');
//     await doneScheduleCollection.add(student);
//     await document.reference.delete();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Schedule marked as done')),
//     );
//   }
//
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
//                   String fetchedDate = document.data()['date'];
//
//                   // Parse the fetched date string into a DateTime object
//                   DateTime fetchedDateTime = DateTime.parse(fetchedDate);
//
//                   // Format the fetched date as a string
//                   String fetchedDateString = DateFormat('yyyy-MM-dd').format(fetchedDateTime);
//
//                   // Compare the fetched date with the current date
//                   return fetchedDateString == currentDateString;
//                 }).toList();
//
//                 // Initialize the visibility list based on the filtered documents count
//                 initializeCheckIconVisibility(filteredDocuments.length);
//
//                 return ListView.builder(
//                   itemCount: filteredDocuments.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     DocumentSnapshot<Map<String, dynamic>> document = filteredDocuments[index];
//                     return listItem(document: document, index: index,onCheckIconTap: () => _onCheckIconTap(document),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//
//           Container(
//             margin: const EdgeInsets.fromLTRB(60, 20, 70, 50),
//             child: Column(
//               children: [
//                 //
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     Navigator.push(context, CupertinoPageRoute(builder: (context) => const DoneSchedule()));
//                 //   },
//                 //   style: ElevatedButton.styleFrom(
//                 //     primary: Color(0xFFC99F4A), // Background color
//                 //   ),
//                 //   child: const Text(
//                 //     'Delete Schedule',
//                 //     style: TextStyle(fontSize: 20),
//                 //   ),
//                 // ),
//               ],
//             ),
//
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider1.dart';
import 'count_provider.dart';

class DoneSchedule extends StatefulWidget {
  const DoneSchedule({Key? key}) : super(key: key);

  @override
  State<DoneSchedule> createState() => _ScheduleState();
}

//
class _ScheduleState extends State<DoneSchedule> {
  CollectionReference<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection('doneschedule');

  Widget listItem(
      {required DocumentSnapshot<Map<String, dynamic>> document,
      required int index,
      required VoidCallback onCheckIconTap}) {
    Map<String, dynamic> student = document.data()!;

    if (index >=
        Provider.of<CountProvider>(context).isCheckIconVisibleList.length) {
      return Container(); // Return an empty container if the index is out of range
    }

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
          SizedBox(width: 80.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    SizedBox(width: 5.w),
                    Visibility(
                      // visible: !Provider.of<CountProvider>(context).isCheckIconVisibleList[index],
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 35.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  // Provider.of<CountProvider>(context, listen: false).decrementCount();
                  if (!Provider.of<CountProvider>(context, listen: false)
                      .isCheckIconVisibleList[index]) {
                    Provider.of<CountProvider>(context, listen: false)
                        .decrementCount();
                  }
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

  // void initializeCheckIconVisibility(int length) {
  //   if (Provider.of<CountProvider>(context, listen: false).isCheckIconVisibleList.isEmpty) {
  //     Provider.of<CountProvider>(context, listen: false).initializeVisibilityList(length);
  //   }
  // }
  void initializeCheckIconVisibility(int length) {
    if (Provider.of<CountProvider>(context, listen: false)
            .isCheckIconVisibleList
            .length <
        length) {
      Provider.of<CountProvider>(context, listen: false)
          .initializeVisibilityList(length);
    }
  }

  void _onCheckIconTap(DocumentSnapshot<Map<String, dynamic>> document) async {
    Map<String, dynamic> student = document.data()!;

    CollectionReference<Map<String, dynamic>> doneScheduleCollection =
        FirebaseFirestore.instance.collection('doneschedule');
    await doneScheduleCollection.add(student);
    await document.reference.delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Schedule marked as done')),
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
                  return fetchedDateString == currentDateString &&
                      fetchedMobileNumber == currentUserMobileNumber;
                }).toList();

                // Initialize the visibility list based on the filtered documents count
                initializeCheckIconVisibility(filteredDocuments.length);

                return ListView.builder(
                  itemCount: filteredDocuments.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot<Map<String, dynamic>> document =
                        filteredDocuments[index];
                    return listItem(
                      document: document,
                      index: index,
                      onCheckIconTap: () => _onCheckIconTap(document),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(60, 20, 70, 50),
            child: const Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
