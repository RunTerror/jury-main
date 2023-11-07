// // import 'package:calendarwithbackend/schedule.dart';
// // import 'package:calendarwithbackend/showupcomingschedule.dart';
// import 'schedule.dart';
// import 'showupcmingschedule.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'count_provider.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
//
// class Calendar extends StatefulWidget {
//   const Calendar({Key? key}) : super(key: key);
//   @override
//   State<Calendar> createState() => _CalendarState();
// }
//
// class _CalendarState extends State<Calendar> {
//   int totalCount = 0;
//   int count = 0;
//   int left = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     // fetchTotalCount();// Fetch the initial totalCount
//     print('come back');
//     final countProvider = Provider.of<CountProvider>(context, listen: false);
//     final countStream = countProvider.getCountStream();
//
//     countStream.listen((data) {
//       setState(() {
//         count = data; // Retrieve the length of the data
//       });
//     });
//   }
//
//   late final countProvider;
//
//   //creating the list , to store the upcoming date from the database
//   List<DateTime> fetchedDates = [];
//   // late int totalCount;
//
//   final _calendarControllerToday = AdvancedCalendarController.today();
//
//   // for showing only today date highlight
//   // final events = <DateTime>[
//   //   DateTime.now(),
//   // ];
//
//   CollectionReference<Map<String, dynamic>> collectionRef =
//       FirebaseFirestore.instance.collection('users');
//
//   Widget listItem({required DocumentSnapshot<Map<String, dynamic>> document}) {
//     Map<String, dynamic> student = document.data()!;
//
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.all(15),
//         padding: const EdgeInsets.all(12),
//         // height: 80,
//         width: 170,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: const Color(0xFFC99F4A)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   student['name'],
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xFFC99F4A),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Row(
//                   children: [
//                     const SizedBox(width: 15),
//                     Text(
//                       student['date'],
//                       style: const TextStyle(
//                           fontSize: 11, fontWeight: FontWeight.w400),
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       student['time'],
//                       style: const TextStyle(
//                           fontSize: 11, fontWeight: FontWeight.w400),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     late final countProvider = Provider.of<CountProvider>(context);
//     // final countStream = countProvider.getCountStream();
//     // count = countStream.count;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           title: const Center(child: Text('Calendar')),
//         ),
//         body: StreamBuilder<int>(
//             stream: countProvider.getTotalCountStream(),
//             builder: (context, snapshot) {
//               // totalCount = snapshot.data!;
//               // left = totalCount - count;
//               if (snapshot.hasData) {
//                 totalCount = snapshot.data! + count;
//                 left = totalCount - count;
//                 return ListView(
//                   scrollDirection: Axis.vertical,
//                   children: [
//                     // for the searching
//                     const SizedBox(
//                       height: 1,
//                     ),
//
//                     //for the search bar and search button
//                     Stack(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(10, 10, 70, 10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(color: Colors.black, width: 1.5),
//                           ),
//                           child: const Row(
//                             children: [
//                               Expanded(
//                                 child: Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: TextField(
//                                     decoration: InputDecoration(
//                                       hintText: 'Search for a meeting',
//                                       border: InputBorder.none,
//                                       contentPadding: EdgeInsets.all(10),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           right: 10,
//                           top: 10,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: IconButton(
//                               onPressed: () {
//                                 // Handle search button click
//                               },
//                               icon: const Icon(
//                                 Icons.search,
//                                 color: Color(0xDECEB300),
//                                 size: 30,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     //for the calendar
//                     SizedBox(
//                       height: 270,
//                       child: AdvancedCalendar(
//                         controller: _calendarControllerToday,
//                         events: fetchedDates,
//                         startWeekDay: 1,
//                       ),
//                     ),
//
//                     //Task overview container with the row which also contain the container
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Text(
//                           'Task Overview',
//                           style: TextStyle(
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 05,
//                     ),
//                     SizedBox(
//                       height: 160,
//                       child: Row(
//                         // crossAxisCount: 3,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 180,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: const Color(0xFFC99F4A), width: 2.0),
//                               ),
//                               child: Transform.translate(
//                                 offset: const Offset(0, 20),
//                                 child: Column(
//                                   children: [
//                                     const Text(
//                                       'Total',
//                                       style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Text(
//                                       totalCount.toString(),
//                                       style: const TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFFC99F4A),
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 180,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: const Color(0xFFC99F4A), width: 2.0),
//                               ),
//                               child: Transform.translate(
//                                 offset: const Offset(0, 20),
//                                 child: Column(
//                                   children: [
//                                     const Text(
//                                       'Left',
//                                       style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Text(
//                                       left.toString(),
//                                       style: const TextStyle(
//                                           fontSize: 25,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFFC99F4A)),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 180,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: const Color(0xFFC99F4A), width: 2.0),
//                               ),
//                               child: Transform.translate(
//                                 offset: const Offset(0, 20),
//                                 child: Column(
//                                   children: [
//                                     const Text(
//                                       'Done',
//                                       style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Text(
//                                       count.toString(),
//                                       style: const TextStyle(
//                                           fontSize: 25,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFFC99F4A)),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // with the total count
//                     const SizedBox(
//                       height: 10,
//                     ),
//
//                     //   Schedule text and the container(which contain the name and day)
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           const Text(
//                             'Schedule',
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(width: 190),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   CupertinoPageRoute(
//                                       builder: (context) => const Schedule()));
//                             },
//                             child: Text(
//                               'SEE ALL',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.combine([
//                                   TextDecoration.underline,
//                                 ]),
//                                 color: const Color(0xFFC99F4A),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         height: 100,
//                         width: 800,
//                         child:
//                             StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                           stream: collectionRef.snapshots(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                                   snapshot) {
//                             if (snapshot.hasError) {
//                               return Text('Error: ${snapshot.error}');
//                             }
//
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
//                             }
//
//                             // Get the current date
//                             DateTime currentDate = DateTime.now();
//                             String currentDateString =
//                                 DateFormat('yyyy-MM-dd').format(currentDate);
//
//                             // Filter the documents based on the date condition
//                             List<DocumentSnapshot<Map<String, dynamic>>>
//                                 filteredDocuments =
//                                 snapshot.data!.docs.where((document) {
//                               // Get the fetched date from the document data
//                               String fetchedDate = document.data()['date'];
//
//                               // Parse the fetched date string into a DateTime object
//                               DateTime fetchedDateTime =
//                                   DateTime.parse(fetchedDate);
//
//                               // Format the fetched date as a string
//                               String fetchedDateString =
//                                   DateFormat('yyyy-MM-dd')
//                                       .format(fetchedDateTime);
//
//                               // Compare the fetched date with the current date
//                               return fetchedDateString == currentDateString;
//                             }).toList();
//
//                             return ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: filteredDocuments.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 DocumentSnapshot<Map<String, dynamic>>
//                                     document = filteredDocuments[index];
//                                 return listItem(document: document);
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(
//                       height: 15,
//                     ),
//
//                     //schedule upcoming content
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           const Text(
//                             'Schedule Upcoming',
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(width: 70),
//                           GestureDetector(
//                             onTap: () {
//                               // Handle button click here
//                               Navigator.push(
//                                   context,
//                                   CupertinoPageRoute(
//                                       builder: (context) =>
//                                           const Addschedule()));
//                             },
//                             child: Text(
//                               'SEE ALL',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.combine([
//                                   TextDecoration.underline,
//                                 ]),
//                                 color: const Color(0xFFC99F4A),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         height: 100,
//                         width: 800,
//                         child:
//                             StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                           stream: collectionRef.snapshots(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                                   snapshot) {
//                             if (snapshot.hasError) {
//                               return Text('Error: ${snapshot.error}');
//                             }
//                             // int totalCount = snapshot.data!.docs.length;
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
//                             }
//
//                             // Get the current date
//                             DateTime currentDate = DateTime.now();
//                             String currentDateString =
//                                 DateFormat('yyyy-MM-dd').format(currentDate);
//
//                             // Filter the documents based on the date condition
//                             List<DocumentSnapshot<Map<String, dynamic>>>
//                                 filteredDocuments =
//                                 snapshot.data!.docs.where((document) {
//                               // Get the fetched date from the document data
//                               String fetchedDate = document.data()['date'];
//
//                               // Parse the fetched date string into a DateTime object
//                               DateTime fetchedDateTime =
//                                   DateTime.parse(fetchedDate);
//
//                               fetchedDates.add(fetchedDateTime);
//
//                               // Format the fetched date as a string
//                               String fetchedDateString =
//                                   DateFormat('yyyy-MM-dd')
//                                       .format(fetchedDateTime);
//
//                               // Compare the fetched date with the current date
//                               return fetchedDateString != currentDateString;
//                             }).toList();
//
//                             return ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: filteredDocuments.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 DocumentSnapshot<Map<String, dynamic>>
//                                     document = filteredDocuments[index];
//                                 return listItem(document: document);
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(
//                       height: 05,
//                     ),
//                     const SizedBox(
//                       height: 05,
//                     ),
//
//                     // Add more containers, texts, or widgets here
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             }),
//       ),
//     );
//   }
// }

// import 'package:calendarwithbackend/schedule.dart';
// import 'package:calendarwithbackend/showupcomingschedule.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/hamburgerMenu/hamburgerIcon.dart';

import '../provider1.dart';
import 'schedule.dart';
import 'showupcmingschedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'count_provider.dart';
// import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int totalCount = 0;
  int count = 0;
  int left = 0;

  @override
  void initState() {
    super.initState();
    print('Calendar start here');
    print(Provider.of<UserProvider>(context, listen: false).user.mobileNumber);
    // fetchTotalCount();// Fetch the initial totalCount
    print('come back');
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    countProvider.setContext(context);
    final countStream = countProvider.getCountStream();

    countStream.listen((data) {
      setState(() {
        count = data; // Retrieve the length of the data
      });
    });
  }

  late final countProvider;

  //creating the list , to store the upcoming date from the database
  List<DateTime> fetchedDates = [];
  // late int totalCount;

  final _calendarControllerToday = AdvancedCalendarController.today();

  // for showing only today date highlight
  // final events = <DateTime>[
  //   DateTime.now(),
  // ];

  CollectionReference<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection('events');

  Widget listItem({required DocumentSnapshot<Map<String, dynamic>> document}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Map<String, dynamic> student = document.data()!;

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(12),
      // height: 80,
      width: 170.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
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
              const SizedBox(height: 5),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Text(
                    student['date'],
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    student['time'],
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    late final countProvider = Provider.of<CountProvider>(context);
    final String currentUserMobileNumber =
        Provider.of<UserProvider>(context, listen: false).user.mobileNumber;

    // final countStream = countProvider.getCountStream();
    // count = countStream.count;
    return Scaffold(
      drawer: const HamburgerIcon(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeProvider.editext,
        centerTitle: true,
        iconTheme: IconThemeData(color: themeProvider.skipButtonTextColor),
        title: Text(
          "Calendar",
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Satoshi',
            color: themeProvider.lightHamText,
            // fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: themeProvider.skipButtonTextColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 148.h,
              decoration:
                  BoxDecoration(gradient: themeProvider.scaffoldGradient),
              child: StreamBuilder<int>(
                  stream: countProvider.getTotalCountStream(),
                  builder: (context, snapshot) {
                    // totalCount = snapshot.data!;
                    // left = totalCount - count;
                    if (snapshot.hasData) {
                      totalCount = snapshot.data! + count;
                      left = totalCount - count;
                      return ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          // for the searching
                          SizedBox(
                            height: 10.h,
                          ),

                          //  // for the search bar and search button
                          //   Stack(
                          //     children: [
                          //       Container(
                          //         margin: const EdgeInsets.fromLTRB(10, 10, 70, 10),
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(5),
                          //           border: Border.all(color: Colors.black, width: 1.5),
                          //         ),
                          //         child: Row(
                          //           children: const [
                          //             Expanded(
                          //               child: Padding(
                          //                 padding: EdgeInsets.symmetric(horizontal: 8.0),
                          //                 child: TextField(
                          //                   decoration: InputDecoration(
                          //                     hintText: 'Search for a meeting',
                          //                     border: InputBorder.none,
                          //                     contentPadding: EdgeInsets.all(10),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Positioned(
                          //         right: 10,
                          //         top: 10,
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             color: Colors.black,
                          //             borderRadius: BorderRadius.circular(10),
                          //           ),
                          //           child: IconButton(
                          //             onPressed: () {
                          //               // Handle search button click
                          //             },
                          //             icon: const Icon(
                          //               Icons.search,
                          //               color: Color(0xDECEB300),
                          //               size: 30,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),

                          //  for the calendar
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.h),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: themeProvider.notesbackground,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black12),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 10,
                                    )
                                  ]),
                              child: Stack(children: [
                                Container(
                                  height: 64.h,
                                  decoration: BoxDecoration(
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     blurRadius: 10
                                    //   )
                                    // ],
                                    color: const Color(0xFFC99F4A),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     blurRadius: 3,
                                    //     // spreadRadius: 10
                                    //   )
                                    // ],
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  height: 320.h,
                                  child: AdvancedCalendar(
                                    calendarTextStyle:
                                        const TextStyle(color: Colors.black),
                                    headerStyle: TextStyle(
                                      fontSize: 25.0.sp,
                                    ),
                                    controller: _calendarControllerToday,
                                    events: fetchedDates,
                                    startWeekDay: 1,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          // AdvancedCalendar(
                          //               calendarTextStyle: TextStyle(  color: Colors.amber,),
                          //               todayStyle: TextStyle(color: themeProvider.casestext),
                          //               headerStyle:  TextStyle(
                          //                   color: themeProvider.casestext,
                          //                 fontSize: 25.0,

                          //               ),
                          //               controller: _calendarControllerToday,
                          //               events: fetchedDates,
                          //               startWeekDay: 1,
                          //             ),

                          //Task overview container with the row which also contain the container
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Task Overview',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 05.h,
                          ),
                          SizedBox(
                            height: 160.h,
                            child: Row(
                              // crossAxisCount: 3,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 180.h,
                                    width: 110.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xFFC99F4A),
                                          width: 2.0.w),
                                    ),
                                    child: Transform.translate(
                                      offset: const Offset(0, 20),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Total',
                                            style: TextStyle(
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.bold,
                                              color: themeProvider.casestext,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Text(
                                            totalCount.toString(),
                                            style: TextStyle(
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFFC99F4A),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 180.h,
                                    width: 110.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xFFC99F4A),
                                          width: 2.0),
                                    ),
                                    child: Transform.translate(
                                      offset: const Offset(0, 20),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Left',
                                            style: TextStyle(
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.bold,
                                              color: themeProvider.casestext,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Text(
                                            left.toString(),
                                            style: TextStyle(
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFFC99F4A)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 180.h,
                                    width: 110.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xFFC99F4A),
                                          width: 2.0),
                                    ),
                                    child: Transform.translate(
                                      offset: const Offset(0, 20),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Done',
                                            style: TextStyle(
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.bold,
                                              color: themeProvider.casestext,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Text(
                                            count.toString(),
                                            style: TextStyle(
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFFC99F4A)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // with the total count
                          SizedBox(
                            height: 10.h,
                          ),

                          //   Schedule text and the container(which contain the name and day)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Schedule',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: themeProvider.casestext,
                                  ),
                                ),
                                //SizedBox(width: MediaQuery.of(context).size.width-175.w,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const Schedule()));
                                  },
                                  child: Text(
                                    'SEE ALL',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.combine([
                                        TextDecoration.underline,
                                      ]),
                                      color: const Color(0xFFC99F4A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: 110.h,
                              width: 800.w,
                              child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                stream: collectionRef.snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                                  }

                                  // Get the current date
                                  DateTime currentDate = DateTime.now();
                                  String currentDateString =
                                      DateFormat('yyyy-MM-dd')
                                          .format(currentDate);

                                  // Filter the documents based on the date condition
                                  List<DocumentSnapshot<Map<String, dynamic>>>
                                      filteredDocuments =
                                      snapshot.data!.docs.where((document) {
                                    // Get the fetched date from the document data
                                    String fetchedDate =
                                        document.data()['date'];
                                    String fetchedMobileNumber =
                                        document.data()['mobile'];

                                    // Parse the fetched date string into a DateTime object
                                    DateTime fetchedDateTime =
                                        DateTime.parse(fetchedDate);

                                    // Format the fetched date as a string
                                    String fetchedDateString =
                                        DateFormat('yyyy-MM-dd')
                                            .format(fetchedDateTime);

                                    // Compare the fetched date with the current date
                                    return fetchedDateString ==
                                            currentDateString &&
                                        fetchedMobileNumber ==
                                            currentUserMobileNumber;
                                  }).toList();

                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: filteredDocuments.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DocumentSnapshot<Map<String, dynamic>>
                                          document = filteredDocuments[index];
                                      return listItem(document: document);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15.h,
                          ),

                          //schedule upcoming content
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Schedule Upcoming',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: themeProvider.casestext,
                                  ),
                                ),
                                //SizedBox(width: MediaQuery.of(context).size.width-295.w,),
                                GestureDetector(
                                  onTap: () {
                                    // Handle button click here
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const Addschedule()));
                                  },
                                  child: Text(
                                    'SEE ALL',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.combine([
                                        TextDecoration.underline,
                                      ]),
                                      color: const Color(0xFFC99F4A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: 110.h,
                              width: 800.w,
                              child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                stream: collectionRef.snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  // int totalCount = snapshot.data!.docs.length;
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                                  }

                                  // Get the current date
                                  DateTime currentDate = DateTime.now();
                                  String currentDateString =
                                      DateFormat('yyyy-MM-dd')
                                          .format(currentDate);

                                  // Filter the documents based on the date condition
                                  List<DocumentSnapshot<Map<String, dynamic>>>
                                      filteredDocuments =
                                      snapshot.data!.docs.where((document) {
                                    // Get the fetched date from the document data
                                    String fetchedDate =
                                        document.data()['date'];
                                    String fetchedMobileNumber =
                                        document.data()['mobile'];

                                    // Parse the fetched date string into a DateTime object
                                    DateTime fetchedDateTime =
                                        DateTime.parse(fetchedDate);

                                    fetchedDates.add(fetchedDateTime);

                                    // Format the fetched date as a string
                                    String fetchedDateString =
                                        DateFormat('yyyy-MM-dd')
                                            .format(fetchedDateTime);

                                    // Compare the fetched date with the current date
                                    return fetchedDateString !=
                                            currentDateString &&
                                        fetchedMobileNumber ==
                                            currentUserMobileNumber;
                                  }).toList();

                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: filteredDocuments.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DocumentSnapshot<Map<String, dynamic>>
                                          document = filteredDocuments[index];
                                      return listItem(document: document);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 10.h),

                          // Add more containers, texts, or widgets here
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
