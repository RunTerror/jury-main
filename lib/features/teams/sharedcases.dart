// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'caseallow.dart';
// class SharedCasesPage extends StatefulWidget {
//   static const String routeName = 'shared_cases';

//   @override
//   _SharedCasesPageState createState() => _SharedCasesPageState();
// }

// class _SharedCasesPageState extends State<SharedCasesPage> {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   CollectionReference _usersCollection = FirebaseFirestore.instance.collection('lawyers');

//   List<String> sharedCases = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchSharedCases();
//   }

//   Future<void> fetchSharedCases() async {
//     User? currentUser = _auth.currentUser;

//     if (currentUser != null && currentUser.uid != null) {
//       String currentUserId = currentUser.uid!;

//       DocumentSnapshot userSnapshot = await _usersCollection.doc(currentUserId).get();

//       if (userSnapshot.exists) {
//         Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

//         if (userData != null && userData.containsKey('sharedcases')) {
//           setState(() {
//             sharedCases = List<String>.from(userData['sharedcases']);
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             sharedCases = [];
//             isLoading = false;
//           });
//         }
//       }
//     }
//   }

// ignore_for_file: use_build_context_synchronously

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shared Cases'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : sharedCases.isNotEmpty
//               ? ListView.builder(
//   itemCount: sharedCases.length,
//   itemBuilder: (context, index) {
//     return ListTile(
//       title: Text(sharedCases[index]),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CaseDetailsPage(casid: sharedCases[index],),
//           ),
//         );
//       },
//     );
//   },
// )
//               : Center(child: Text('No shared cases found.')),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:juridentt/addcase/casenotes.dart';
// import 'package:juridentt/addcase/editcase.dart';
// import 'package:firebase_performance/firebase_performance.dart';
// import 'package:provider/provider.dart';
// import 'package:juridentt/addcase/provider.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../../hamburgerMenu/hamburgerIcon.dart';

// class SharedCasesPage extends StatefulWidget {
//   static const String routeName = 'shared_cases';

//   const SharedCasesPage({super.key});

//   @override
//   State<SharedCasesPage> createState() => _SharedCasesPageState();
// }

// class _SharedCasesPageState extends State<SharedCasesPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final CollectionReference _usersCollection =
//       FirebaseFirestore.instance.collection('lawyers');
//   List<String> sharedCases = [];
//   bool isLoading = true;
//   List<DocumentSnapshot> caseDocuments = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchSharedCases();
//   }

//   Future<void> fetchSharedCases() async {
//     final trace = FirebasePerformance.instance.newTrace('fetchSharedCases');
//     await trace.start();
//     User? currentUser = _auth.currentUser;

//     if (currentUser != null) {
//       String currentUserId = currentUser.uid;
//       DocumentSnapshot userSnapshot =
//           await _usersCollection.doc(currentUserId).get();

//       if (userSnapshot.exists) {
//         Map<String, dynamic>? userData =
//             userSnapshot.data() as Map<String, dynamic>?;

//         if (userData != null && userData.containsKey('sharedcases')) {
//           setState(() {
//             sharedCases = List<String>.from(userData['sharedcases']);
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             sharedCases = [];
//             isLoading = false;
//           });
//         }
//       }
//     }

//     List<Future<DocumentSnapshot>> futureDocuments = sharedCases.map((caseNo) {
//       return getCaseDocument(caseNo);
//     }).toList();

//     List<DocumentSnapshot> results =
//         await Future.wait<DocumentSnapshot>(futureDocuments);

//     await trace.stop();

//     setState(() {
//       caseDocuments = results.whereType<DocumentSnapshot>().toList();
//     });
//   }
//   // Future<DocumentSnapshot> getCaseDocument(String caseNo) async {
//   //   CollectionReference collection1 = FirebaseFirestore.instance.collection('open');
//   //   CollectionReference collection2 = FirebaseFirestore.instance.collection('closed');
//   //   CollectionReference collection3 = FirebaseFirestore.instance.collection('upcoming');

//   //   QuerySnapshot querySnapshot1 = await collection1.where('caseNo', isEqualTo: caseNo).get();
//   //   if (querySnapshot1.docs.isNotEmpty) {
//   //     return querySnapshot1.docs.first;
//   //   }

//   //   QuerySnapshot querySnapshot2 = await collection2.where('caseNo', isEqualTo: caseNo).get();
//   //   if (querySnapshot2.docs.isNotEmpty) {
//   //     return querySnapshot2.docs.first;
//   //   }

//   //   QuerySnapshot querySnapshot3 = await collection3.where('caseNo', isEqualTo: caseNo).get();
//   //   if (querySnapshot3.docs.isNotEmpty) {
//   //     return querySnapshot3.docs.first;
//   //   }

//   //   throw Exception('Case document not found');
//   // }
//   Future<DocumentSnapshot> getCaseDocument(String caseNo) async {
//     CollectionReference collection1 =
//         FirebaseFirestore.instance.collection('open');
//     CollectionReference collection2 =
//         FirebaseFirestore.instance.collection('closed');
//     CollectionReference collection3 =
//         FirebaseFirestore.instance.collection('upcoming');

//     List<Future<QuerySnapshot>> queryFutures = [
//       collection1.where('caseNo', isEqualTo: caseNo).get(),
//       collection2.where('caseNo', isEqualTo: caseNo).get(),
//       collection3.where('caseNo', isEqualTo: caseNo).get(),
//     ];

//     List<QuerySnapshot> querySnapshots =
//         await Future.wait<QuerySnapshot>(queryFutures);

//     for (QuerySnapshot querySnapshot in querySnapshots) {
//       if (querySnapshot.docs.isNotEmpty) {
//         return querySnapshot.docs.first;
//       }
//     }

//     throw Exception('Case document not found');
//   }

//   @override
//   Widget build(BuildContext context) {
//     const spinkit = SpinKitWave(
//       color: Colors.white,
//       size: 40.0,
//     );
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Scaffold(
//        appBar: AppBar(
//           iconTheme: IconThemeData(color: themeProvider.hamtext),
//           centerTitle: true,
//           backgroundColor: themeProvider.appbarcolor,
//         elevation: 0,
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: InkWell(
//                 onTap: () {
//                   // Navigator.push(context,
//                   //     MaterialPageRoute(builder: (context) => Profile()));
//                 },
//                 child: Container(
//                     // width: 35,
//                     decoration: BoxDecoration(
//                       // color: Colors.orange,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Icon(
//                       Icons.notifications_outlined,
//                       color: themeProvider.hamtext,
//                     )),
//               ),
//             ),
//           ],
//         ),
//         drawer: const HamburgerIcon(),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: themeProvider.scaffoldGradient,
//         ),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.only(top: 50, bottom: 250),
//           child: Column(
//             children: [
//               Center(
//                 child: Text(
//                   "JURIDENT",
//                   style: TextStyle(
//                     color: themeProvider.darkopp,
//                     fontSize: 30,
//                     fontFamily: 'Satoshi',
//                     fontWeight: FontWeight.w500,
//                     fontStyle: FontStyle.normal,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: Text(
//                   "Shared Cases",
//                   style: TextStyle(
//                     color: themeProvider.darkopp,
//                     fontSize: 30,
//                     fontFamily: 'Satoshi',
//                     fontWeight: FontWeight.w500,
//                     fontStyle: FontStyle.normal,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               isLoading
//                   ? const Center(child: spinkit)
//                   : caseDocuments.isNotEmpty
//                       ? ListView.builder(
//                           shrinkWrap: true,
//                           physics: const BouncingScrollPhysics(),
//                           itemCount: caseDocuments.length,
//                           itemBuilder: (context, index) {
//                             var caseDocument = caseDocuments[index];
//                             var caseData =
//                                 caseDocument.data() as Map<String, dynamic>;
//                             return Container(
//                               margin: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: themeProvider.bordercolor),
//                                 borderRadius: BorderRadius.circular(19),
//                                 color: themeProvider.detailpagebutton,
//                               ),
//                               child: ListTile(
//                                 title: Text(caseData['caseNo'],
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 20,
//                                         color: themeProvider.scaffoldcolor,
//                                         fontWeight: FontWeight.w500)),
//                                 subtitle: Text(caseData['casetype'],
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 20,
//                                         color: themeProvider.scaffoldcolor,
//                                         fontWeight: FontWeight.w500)),
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => CaseDetailsPage(
//                                         caseNumber: caseData['caseNo'],
//                                         caseName: caseData['caseName'],
//                                         partyName: caseData['partyName'],
//                                         courtName: caseData['courtName'],
//                                         hearingDate: caseData['hearingDate'],
//                                         adverseParty: '',
//                                         adversePartyLawyer: '',
//                                         caseType: caseData['casetype'],
//                                         adversePartyContactNo:
//                                             caseData['partyContactNo'],
//                                         casenotes: caseData['casenotes'],
//                                         partyContactNo: '',
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                         )
//                       : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juridentt/addcase/casenotes.dart';
import 'package:juridentt/addcase/editcase.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:provider/provider.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../hamburgerMenu/hamburgerIcon.dart';

class SharedCasesPage extends StatefulWidget {
  static const String routeName = 'shared_cases';

  const SharedCasesPage({Key? key}) : super(key: key);

  @override
  State<SharedCasesPage> createState() => _SharedCasesPageState();
}

class _SharedCasesPageState extends State<SharedCasesPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('lawyers');
  List<String> sharedCases = [];
  bool isLoading = true;
  List<DocumentSnapshot> caseDocuments = [];

  @override
  void initState() {
    super.initState();
    fetchSharedCases();
  }

  Future<List<DocumentSnapshot<Object?>>> fetchSharedCases() async {
    final trace = FirebasePerformance.instance.newTrace('fetchSharedCases');
    await trace.start();

    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      String currentUserId = currentUser.uid;
      DocumentSnapshot userSnapshot =
          await _usersCollection.doc(currentUserId).get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('sharedcases')) {
          sharedCases = List<String>.from(userData['sharedcases']);
          isLoading = false;
        } else {
          sharedCases = [];
          isLoading = false;
        }
      }
    }

    List<Future<DocumentSnapshot<Object?>>> futureDocuments =
        sharedCases.map((caseNo) {
      return getCaseDocument(caseNo);
    }).toList();

    List<DocumentSnapshot<Object?>> results =
        await Future.wait<DocumentSnapshot<Object?>>(futureDocuments);

    await trace.stop();

    return results;
  }

  Future<DocumentSnapshot> getCaseDocument(String caseNo) async {
    CollectionReference collection1 =
        FirebaseFirestore.instance.collection('open');
    CollectionReference collection2 =
        FirebaseFirestore.instance.collection('closed');
    CollectionReference collection3 =
        FirebaseFirestore.instance.collection('upcoming');

    QuerySnapshot querySnapshot1 =
        await collection1.where('caseNo', isEqualTo: caseNo).get();
    if (querySnapshot1.docs.isNotEmpty) {
      return querySnapshot1.docs.first;
    }

    QuerySnapshot querySnapshot2 =
        await collection2.where('caseNo', isEqualTo: caseNo).get();
    if (querySnapshot2.docs.isNotEmpty) {
      return querySnapshot2.docs.first;
    }

    QuerySnapshot querySnapshot3 =
        await collection3.where('caseNo', isEqualTo: caseNo).get();
    if (querySnapshot3.docs.isNotEmpty) {
      return querySnapshot3.docs.first;
    }

    throw Exception('Case document not found');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final spinkit = SpinKitWave(
      color: themeProvider.skipButtonColor,
      size: 40.0.sp,
    );
    //final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: themeProvider.hamtext),
        centerTitle: true,
        backgroundColor: themeProvider.appbarcolor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: themeProvider.hamtext,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: const HamburgerIcon(),
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.scaffoldGradient,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 50.h, bottom: 700.h),
          child: Column(
            children: [
              Center(
                child: Text(
                  "JURIDENT",
                  style: TextStyle(
                    color: themeProvider.darkopp,
                    fontSize: 30.sp,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "Shared Cases",
                  style: TextStyle(
                    color: themeProvider.darkopp,
                    fontSize: 30.sp,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              FutureBuilder<List<DocumentSnapshot>>(
                future: fetchSharedCases(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: spinkit);
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    caseDocuments = snapshot.data ?? [];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: caseDocuments.length,
                      itemBuilder: (context, index) {
                        var caseDocument = caseDocuments[index];
                        var caseData =
                            caseDocument.data() as Map<String, dynamic>;
                        return Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: themeProvider.bordercolor),
                            borderRadius: BorderRadius.circular(10),
                            color: themeProvider.detailpagebutton,
                          ),
                          child: ListTile(
                            title: Text(caseData['caseNo'],
                                style: GoogleFonts.poppins(
                                    fontSize: 20.sp,
                                    color: themeProvider.scaffoldcolor,
                                    fontWeight: FontWeight.w500)),
                            subtitle: Text(caseData['casetype'],
                                style: GoogleFonts.poppins(
                                    fontSize: 20.sp,
                                    color: themeProvider.scaffoldcolor,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CaseDetailsPage(
                                    caseNumber: caseData['caseNo'],
                                    caseName: caseData['caseName'],
                                    partyName: caseData['partyName'],
                                    courtName: caseData['courtName'],
                                    hearingDate: caseData['hearingDate'],
                                    adverseParty: '',
                                    adversePartyLawyer: '',
                                    caseType: caseData['casetype'],
                                    adversePartyContactNo:
                                        caseData['partyContactNo'],
                                    casenotes: caseData['casenotes'],
                                    partyContactNo: '',
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CaseDetailsPage extends StatelessWidget {
  final String caseNumber;
  final String caseName;
  final String partyName;
  final String courtName;
  final String hearingDate;
  final String partyContactNo;
  final String adverseParty;
  final String adversePartyContactNo;
  final String adversePartyLawyer;
  final String caseType;
  final String casenotes;

  const CaseDetailsPage(
      {super.key,
      required this.caseNumber,
      required this.caseName,
      required this.partyName,
      required this.courtName,
      required this.hearingDate,
      required this.partyContactNo,
      required this.adverseParty,
      required this.adversePartyContactNo,
      required this.adversePartyLawyer,
      required this.caseType,
      required this.casenotes});
  void updateCaseDetails(
      BuildContext context, Map<String, dynamic> updatedData) async {
    try {
      // print('update');
      //print(updatedData);
      final CollectionReference casesCollection =
          FirebaseFirestore.instance.collection(caseType);

      final QuerySnapshot<Object?> snapshot = await casesCollection
          .where('caseNo', isEqualTo: caseNumber)
          // .where('casetype', isEqualTo: widget.caseType)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            snapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>;

        // Update the fields with the updatedData
        final Map<String, dynamic> currentData = documentSnapshot.data()!;
        final Map<String, dynamic> newData = {
          ...currentData,
          ...updatedData,
        };

        await documentSnapshot.reference.update(newData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Case details updated successfully')),
        );

        // Refresh case details
        //  fetchCaseDetails();
      }
    } catch (error) {
      //  print('error $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      //backgroundColor: themeProvider.casescaffold,
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.scaffoldGradient,
        ),
        padding: EdgeInsets.only(left: 20.w, top: 50.h),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "JURIDENT",
                  style: TextStyle(
                    color: themeProvider.darkopp,
                    fontSize: 30.sp,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                color: Colors.amber,
                splashColor: Colors.amber,
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back when the back icon is pressed
                },
              ),
              Text(
                'Case ID:$caseNumber',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.sp),
              Text(
                'caseType: $caseType',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              Text(
                'caseName: $caseName',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),

              Text(
                'partyName: $partyName',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),

              Text(
                'courtName: $courtName',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              Text(
                'hearingDate: $hearingDate',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              Text(
                'partyContactNo: $partyContactNo',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              Text(
                ' adverseParty: $adverseParty',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              Text(
                'adverseParty\nContactNumber: $adversePartyContactNo',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              Text(
                'adverseParty\nLawyer: $adversePartyLawyer',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: themeProvider.casestext,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CustomeCaseNotes(
                        lawyerName: "John Doe",
                        time: "2023-06-17 10:00 AM",
                        notes: casenotes),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 100.w),
                  width: 174.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFEABE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'case notes',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditCaseDetailsPage(
                        caseNumber: caseNumber,
                        caseName: caseName,
                        partyName: partyName,
                        courtName: courtName,
                        hearingDate: hearingDate,
                        partyContactNo: partyContactNo,
                        adverseParty: adverseParty,
                        adversePartyContactNo: adversePartyContactNo,
                        adversePartyLawyer: adversePartyLawyer,
                        onUpdate: updateCaseDetails,
                        caseType: caseType,
                        casenotes: casenotes,
                        lawyerName: '',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 360.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: themeProvider.detailpagebutton,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(
                          0,
                          3,
                        ), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Edit Case Details',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              //   Text('partyContactNo: $partyContactNo'),
            ],
          ),
        ),
      ),
    );
  }
}
