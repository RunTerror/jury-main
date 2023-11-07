// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/files/myfiles2.dart';
import 'provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juridentt/addcase/casenotes.dart';
import 'package:juridentt/features/teams/viewaccess.dart';
import 'editcase.dart';
import 'package:google_fonts/google_fonts.dart';

class CaseDetailsPage extends StatefulWidget {
  final String caseNumber;
  final String caseName;
  final String partyName;
  final String lawyerName;

  final String caseType;

  const CaseDetailsPage({
    Key? key,
    required this.caseNumber,
    required this.caseName,
    required this.partyName,
    required this.caseType,
    required this.lawyerName,
  }) : super(key: key);

  @override
  State<CaseDetailsPage> createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  Map<String, dynamic>? caseData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCaseDetails();
  }

  void fetchCaseDetails() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(widget.caseType)
          .where('caseNo', isEqualTo: widget.caseNumber)
          .where('caseName', isEqualTo: widget.caseName)
          .where('partyName', isEqualTo: widget.partyName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            snapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>;

        setState(() {
          caseData = documentSnapshot.data();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Failed to fetch case details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateCaseDetails(
      BuildContext context, Map<String, dynamic> updatedData) async {
    try {
      print('update');
      print(updatedData);
      final CollectionReference casesCollection =
          FirebaseFirestore.instance.collection(widget.caseType);

      final QuerySnapshot<Object?> snapshot = await casesCollection
          .where('caseNo', isEqualTo: widget.caseNumber)
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
        fetchCaseDetails();
      }
    } catch (error) {
      print('error $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    print(widget.caseNumber);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: themeProvider.casescaffold,
          body: Container(
            decoration:
                BoxDecoration(gradient: themeProvider.scaffoldGradientscrol),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 16.h, left: 30.w),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : caseData != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
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
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              'Case Details',
                              style: GoogleFonts.poppins(
                                  fontSize: 28.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Case Number:  ${widget.caseNumber}',
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Case Name:  ${widget.caseName}',
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Party Name:  ${widget.partyName}',
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Court Name: ${caseData!['courtName']}',
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                color: themeProvider.casestext,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Hearing Date:  ${caseData!['hearingDate']}',
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Party Contact No:  ${caseData!['partyContactNo']}',
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Adverse Party:  ${caseData!['adverseParty']}',
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Adverse Party\nContact No:   ${caseData!['adversePartyContactNo']}',
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Adverse Party\nLawyer:   ${caseData!['adversePartyLawyer']}',
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  color: themeProvider.casestext,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (!isLoading && caseData != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditCaseDetailsPage(
                                            caseNumber: widget.caseNumber,
                                            caseName: widget.caseName,
                                            partyName: widget.partyName,
                                            courtName:
                                                caseData!['courtName'] ?? '',
                                            hearingDate:
                                                caseData!['hearingDate'] ?? '',
                                            partyContactNo:
                                                caseData!['partyContactNo'] ??
                                                    '',
                                            adverseParty:
                                                caseData!['adverseParty'] ?? '',
                                            adversePartyContactNo: caseData![
                                                    'adversePartyContactNo'] ??
                                                '',
                                            adversePartyLawyer: caseData![
                                                    'adversePartyLawyer'] ??
                                                '',
                                            onUpdate: updateCaseDetails,
                                            caseType: widget.caseType,
                                            casenotes:
                                                caseData!['casenotes'] ?? '',
                                            lawyerName: widget.lawyerName,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    transform:
                                        Matrix4.translationValues(-12, 0, 0),
                                    width: 171.w,
                                    height: 66.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: themeProvider.detailpagebutton,
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
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Text(
                                        'Edit Case\nDetails',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16.0.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (!isLoading && caseData != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TeamsPage(
                                            casenumber: widget.caseNumber,
                                            casetype: widget.caseType,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 171.w,
                                    height: 66.h,
                                    decoration: BoxDecoration(
                                      color: themeProvider.detailpagebutton,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes the position of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Allow\nAccess',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16.0.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            if (widget.caseType ==
                                'open') // Only show the button if caseType is "open"
                              InkWell(
                                // onTap: () async {
                                //   if (!isLoading && caseData != null) {
                                //     try {
                                //       // Retrieve the case number
                                //       final String caseNumber =
                                //           caseData!['caseNo'];

                                //       // Create a reference to the Firestore instance
                                //       final FirebaseFirestore firestore =
                                //           FirebaseFirestore.instance;

                                //       // Create a reference to the "open" collection
                                //       final CollectionReference
                                //           openCollectionRef =
                                //           firestore.collection(widget.caseType);

                                //       // Query the collection to find the document with the matching case number
                                //       final QuerySnapshot<Object?> snapshot =
                                //           await openCollectionRef
                                //               .where('caseNo',
                                //                   isEqualTo: caseNumber)
                                //               .get();

                                //       if (snapshot.docs.isNotEmpty) {
                                //         final DocumentSnapshot<
                                //                 Map<String, dynamic>>
                                //             documentSnapshot = snapshot.docs.first
                                //                 as DocumentSnapshot<
                                //                     Map<String, dynamic>>;

                                //         // Retrieve the document data
                                //         final Map<String, dynamic> data =
                                //             documentSnapshot.data()!;

                                //         // Create a reference to the "closed" collection
                                //         final CollectionReference
                                //             closedCollectionRef =
                                //             firestore.collection('closed');

                                //         // Add the document data to the "closed" collection with the same document ID
                                //         await closedCollectionRef
                                //             .doc(documentSnapshot.id)
                                //             .set(data);

                                //         // Delete the document from the "open" collection
                                //         await documentSnapshot.reference.delete();

                                //         // Display a success message
                                //         ScaffoldMessenger.of(context)
                                //             .showSnackBar(
                                //           const SnackBar(
                                //               content:
                                //                   Text('Record moved to closed')),
                                //         );
                                //       } else {
                                //         ScaffoldMessenger.of(context)
                                //             .showSnackBar(
                                //           const SnackBar(
                                //               content: Text('Record not found')),
                                //         );
                                //       }
                                //     } catch (error) {
                                //       print('Failed to move record: $error');
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //             content:
                                //                 Text('Failed to move record')),
                                //       );
                                //     }
                                //   }
                                // },
                                onTap: () async {
                                  if (!isLoading && caseData != null) {
                                    try {
                                      // Retrieve the case number
                                      final String caseNumber =
                                          caseData!['caseNo'];

                                      // Create a reference to the Firestore instance
                                      final FirebaseFirestore firestore =
                                          FirebaseFirestore.instance;

                                      // Create a reference to the "open" collection
                                      final CollectionReference
                                          openCollectionRef =
                                          firestore.collection(widget.caseType);

                                      // Query the collection to find the document with the matching case number
                                      final QuerySnapshot<Object?> snapshot =
                                          await openCollectionRef
                                              .where('caseNo',
                                                  isEqualTo: caseNumber)
                                              .get();

                                      if (snapshot.docs.isNotEmpty) {
                                        final DocumentSnapshot<
                                                Map<String, dynamic>>
                                            documentSnapshot =
                                            snapshot.docs.first
                                                as DocumentSnapshot<
                                                    Map<String, dynamic>>;

                                        // Retrieve the document data
                                        final Map<String, dynamic> data =
                                            documentSnapshot.data()!;
                                        // Create a reference to the "closed" collection
                                        final CollectionReference
                                            closedCollectionRef =
                                            firestore.collection('closed');

                                        // Update the caseType to "closed" in the document data
                                        data['caseType'] = 'closed';

                                        // Add the document data to the "closed" collection with the same document ID
                                        await closedCollectionRef
                                            .doc(documentSnapshot.id)
                                            .set(data);

                                        // Delete the document from the "open" collection
                                        await documentSnapshot.reference
                                            .delete();

                                        // Display a success message
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Record moved to closed')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Record not found')),
                                        );
                                      }
                                    } catch (error) {
                                      print('Failed to move record: $error');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Failed to move record')),
                                      );
                                    }
                                  }
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
                                        offset: const Offset(0,
                                            3), // changes the position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      'Close case',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.0.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 10.h,
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => CustomeCaseNotes(
                                    lawyerName: widget.lawyerName,
                                    time: "2023-06-17 10:00 AM",
                                    notes: caseData!['casenotes'] ?? '',
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 80.w),
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
                            SizedBox(
                              height: 20.h,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Myfiles2(
                                      type: '2',
                                      caseNumber: widget.caseNumber,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 78.w),
                                width: 174.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFEABE),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'case files',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: Text('Failed to fetch case details')),
            ),
          ),
        );
      },
    );
  }
}
