//
//
//
//  // done delete bala part tk shi kaam kr rha hai, done ko store krni ki prblm hai
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:intl/intl.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'addschedule.dart';
// // import 'count_provider.dart';
// //
// // class Schedule extends StatefulWidget {
// //   const Schedule({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Schedule> createState() => _ScheduleState();
// // }
// // //
// // class _ScheduleState extends State<Schedule> {
// //   CollectionReference<Map<String, dynamic>> collectionRef = FirebaseFirestore.instance.collection('users');
// //
// //   Widget listItem({required DocumentSnapshot<Map<String, dynamic>> document, required int index}) {
// //     Map<String, dynamic> student = document.data()!;
// //
// //     return Container(
// //       margin: const EdgeInsets.all(15),
// //       padding: const EdgeInsets.all(15),
// //       height: 80,
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(10),
// //         border: Border.all(color: Color(0xFFC99F4A)),
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Column(
// //             children: [
// //               Text(
// //                 student['name'],
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w400,
// //                   color: Color(0xFFC99F4A),
// //                 ),
// //               ),
// //               const SizedBox(height: 5),
// //               Row(
// //                 children: [
// //                   SizedBox(width: 10),
// //                   Text(
// //                     student['date'],
// //                     style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
// //                   ),
// //                   SizedBox(width: 5),
// //                   Text(
// //                     student['time'],
// //                     style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //           const SizedBox(width: 80),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.end,
// //             crossAxisAlignment: CrossAxisAlignment.end,
// //             children: [
// //               GestureDetector(
// //                 // onTap: () {
// //                 //   Provider.of<CountProvider>(context, listen: false).incrementCount();
// //                 //   Provider.of<CountProvider>(context, listen: false).toggleVisibility(index);
// //                 // },
// //
// //                 // child: Row(
// //                 //   children: [
// //                 //     Visibility(
// //                 //       visible: Provider.of<CountProvider>(context).isCheckIconVisibleList[index],
// //                 //       child: Icon(
// //                 //         Icons.check_box_outline_blank,
// //                 //         color: Color(0xFFC99F4A),
// //                 //       ),
// //                 //       replacement: const Icon(
// //                 //         Icons.done,
// //                 //         color: Color(0xFFC99F4A),
// //                 //       ),
// //                 //     ),
// //                 //     SizedBox(width: 5),
// //                 //     const Text(
// //                 //       'Done',
// //                 //       // Provider.of<CountProvider>(context).count.toString(),
// //                 //       style: TextStyle(
// //                 //         fontSize: 14,
// //                 //         color: Colors.green,
// //                 //         fontWeight: FontWeight.bold,
// //                 //       ),
// //                 //     ),
// //                 //   ],
// //                 // ),
// //                 child: Row(
// //                   children: [
// //                     GestureDetector(
// //                       onTap: () {
// //                         Provider.of<CountProvider>(context, listen: false).incrementCount();
// //                         Provider.of<CountProvider>(context, listen: false).toggleVisibility(index);
// //                       },
// //                       child: Visibility(
// //                         visible: Provider.of<CountProvider>(context).isCheckIconVisibleList[index],
// //                         child: Icon(
// //                           Icons.check,
// //                           color: Color(0xFFC99F4A),
// //                         ),
// //                       ),
// //                     ),
// //                     SizedBox(width: 5),
// //                     Visibility(
// //                       visible: !Provider.of<CountProvider>(context).isCheckIconVisibleList[index],
// //                       child: const Text(
// //                         'Done',
// //                         style: TextStyle(
// //                           fontSize: 14,
// //                           color: Colors.green,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //
// //               ),
// //             ],
// //           ),
// //
// //           const SizedBox(width: 35),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.end,
// //             crossAxisAlignment: CrossAxisAlignment.end,
// //             children: [
// //               GestureDetector(
// //                 onTap: () {
// //                   // Provider.of<CountProvider>(context, listen: false).decrementCount();
// //                   if (!Provider.of<CountProvider>(context, listen: false).isCheckIconVisibleList[index]) {
// //                     Provider.of<CountProvider>(context, listen: false).decrementCount();
// //                   }
// //                   document.reference.delete();
// //                 },
// //                 child: Row(
// //                   children: const [
// //                     Icon(
// //                       Icons.delete,
// //                       color: Color(0xFFC99F4A),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // void initializeCheckIconVisibility(int length) {
// //   //   if (Provider.of<CountProvider>(context, listen: false).isCheckIconVisibleList.isEmpty) {
// //   //     Provider.of<CountProvider>(context, listen: false).initializeVisibilityList(length);
// //   //   }
// //   // }
// //   void initializeCheckIconVisibility(int length) {
// //     if (Provider.of<CountProvider>(context, listen: false).isCheckIconVisibleList.length < length) {
// //       Provider.of<CountProvider>(context, listen: false).initializeVisibilityList(length);
// //     }
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: ListView(
// //         children: [
// //           SizedBox(height: 20),
// //           Container(
// //             height: 600,
// //             child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
// //               stream: collectionRef.snapshots(),
// //               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
// //                 if (snapshot.hasError) {
// //                   return Text('Error: ${snapshot.error}');
// //                 }
// //
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
// //                 }
// //
// //                 // Get the current date
// //                 DateTime currentDate = DateTime.now();
// //                 String currentDateString = DateFormat('yyyy-MM-dd').format(currentDate);
// //
// //                 // Filter the documents based on the date condition
// //                 List<DocumentSnapshot<Map<String, dynamic>>> filteredDocuments = snapshot.data!.docs.where((document) {
// //                   // Get the fetched date from the document data
// //                   String fetchedDate = document.data()['date'];
// //
// //                   // Parse the fetched date string into a DateTime object
// //                   DateTime fetchedDateTime = DateTime.parse(fetchedDate);
// //
// //                   // Format the fetched date as a string
// //                   String fetchedDateString = DateFormat('yyyy-MM-dd').format(fetchedDateTime);
// //
// //                   // Compare the fetched date with the current date
// //                   return fetchedDateString == currentDateString;
// //                 }).toList();
// //
// //                 // Initialize the visibility list based on the filtered documents count
// //                 initializeCheckIconVisibility(filteredDocuments.length);
// //
// //                 return ListView.builder(
// //                   itemCount: filteredDocuments.length,
// //                   itemBuilder: (BuildContext context, int index) {
// //                     DocumentSnapshot<Map<String, dynamic>> document = filteredDocuments[index];
// //                     return listItem(document: document, index: index);
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //           Container(
// //             margin: const EdgeInsets.fromLTRB(60, 60, 70, 10),
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(context, CupertinoPageRoute(builder: (context) => const AddSchedule()));
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 primary: Color(0xFFC99F4A), // Background color
// //               ),
// //               child: const Text(
// //                 'Add Schedule',
// //                 style: TextStyle(fontSize: 20),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
//
//
// //next approach using the new branch
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'addschedule.dart';
// import 'count_provider.dart';
// import 'doneschedule.dart';
//
// class Schedule extends StatefulWidget {
//   const Schedule({Key? key}) : super(key: key);
//
//   @override
//   State<Schedule> createState() => _ScheduleState();
// }
// //
// class _ScheduleState extends State<Schedule> {
//   CollectionReference<Map<String, dynamic>> collectionRef = FirebaseFirestore.instance.collection('users');
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
//                   children: [
//                     GestureDetector(
//
//                       onTap: onCheckIconTap,
//                       child: Visibility(
//                         visible: Provider.of<CountProvider>(context).isCheckIconVisibleList[index],
//                         child: const Icon(
//                           Icons.check,
//                           color: Color(0xFFC99F4A),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Visibility(
//                       visible: !Provider.of<CountProvider>(context).isCheckIconVisibleList[index],
//                       child: const Text(
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
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context, CupertinoPageRoute(builder: (context) => const AddSchedule()));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xFFC99F4A), // Background color
//                   ),
//                   child: const Text(
//                     'Add Schedule',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context, CupertinoPageRoute(builder: (context) => const DoneSchedule()));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xFFC99F4A), // Background color
//                   ),
//                   child: const Text(
//                     'Done Schedule',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ],
//             ),
//
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//

//next approach using the new branch
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider1.dart';
import 'addschedule.dart';
import 'count_provider.dart';
import 'doneschedule.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

//
class _ScheduleState extends State<Schedule> {
  CollectionReference<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection('events');

  Widget listItem(
      {required DocumentSnapshot<Map<String, dynamic>> document,
      required int index,
      required VoidCallback onCheckIconTap}) {
    Map<String, dynamic> student = document.data()!;

    //for removing the error of the setState() or marksNeedState() called during
    if (index >=
        Provider.of<CountProvider>(context).isCheckIconVisibleList.length) {
      return Container(); // Return an empty container if the index is out of range
    }

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      height: 80,
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
                    GestureDetector(
                      onTap: onCheckIconTap,
                      child: Visibility(
                        visible: Provider.of<CountProvider>(context)
                            .isCheckIconVisibleList[index],
                        child: const Icon(
                          Icons.check,
                          color: Color(0xFFC99F4A),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Visibility(
                      visible: !Provider.of<CountProvider>(context)
                          .isCheckIconVisibleList[index],
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

  void initializeCheckIconVisibility(int length) {
    if (Provider.of<CountProvider>(context, listen: false)
            .isCheckIconVisibleList
            .length <
        length) {
      Provider.of<CountProvider>(context, listen: false)
          .initializeVisibilityList(length);
    }
  }

  void _onCheckIconTap(
      DocumentSnapshot<Map<String, dynamic>> document, int index) async {
    Map<String, dynamic> student = document.data()!;
    Provider.of<CountProvider>(context, listen: false).toggleVisibility(index);

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
    return ChangeNotifierProvider(
      create: (context) => CountProvider(),
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 20.h),
            SizedBox(
              height: 600.h,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: collectionRef.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
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
                  List<DocumentSnapshot<Map<String, dynamic>>>
                      filteredDocuments = snapshot.data!.docs.where((document) {
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
                        onCheckIconTap: () => _onCheckIconTap(document, index),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(60.w, 20.h, 70.w, 50.h),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const AddSchedule()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC99F4A), // Background color
                    ),
                    child: Text(
                      'Add Schedule',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const DoneSchedule()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC99F4A), // Background color
                    ),
                    child: Text(
                      'Done Schedule',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
