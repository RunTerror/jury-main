import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/bookmarks/bookmarkspage.dart';
import 'package:juridentt/widgets/file_new.dart';

class Myfiles3 extends StatefulWidget {
  const Myfiles3({Key? key}) : super(key: key);

  @override
  State<Myfiles3> createState() => _Myfiles3State();
}

class _Myfiles3State extends State<Myfiles3> {
  List<Map<String, dynamic>> fileData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final String lawyerId = FirebaseAuth.instance.currentUser!.uid;

    final QuerySnapshot caseSnapshot = await FirebaseFirestore.instance
        .collection('files')
        .where('lawyer_uid', isEqualTo: lawyerId)
        .get();

    final List<Map<String, dynamic>> data = [];

    // Add case data
    for (var document in caseSnapshot.docs) {
      String caseNumber = document['caseNo'] ?? '';
      String fileName = document['fileName'] ?? '';
      String fileUrl = document['file_url'] ?? '';
      Map<String, dynamic> caseData = {
        'caseNo': caseNumber,
        'fileName': fileName,
        'fileUrl': fileUrl,
      };
      data.add(caseData);
    }

    // Add case details
    for (int i = 0; i < data.length; i++) {
      final Map<String, dynamic> caseData = data[i];
      final String caseNumber = caseData['caseNo'] ?? '';

      final QuerySnapshot caseDetailsSnapshot = await FirebaseFirestore.instance
          .collection('open')
          .where('caseNo', isEqualTo: caseNumber)
          .get();

      for (var document in caseDetailsSnapshot.docs) {
        String caseName = document['caseName'] ?? '';
        String partyName = document['partyName'] ?? '';

        Map<String, dynamic> caseDetailsData = {
          'caseName': caseName,
          'partyName': partyName,
        };

        // Merge case data and case details data into one map
        Map<String, dynamic> mergedData = {
          ...caseData,
          ...caseDetailsData,
        };

        // Replace the item in the list with the merged data
        data[i] = mergedData;
      }
      final QuerySnapshot caseDetailsSnapshot1 = await FirebaseFirestore
          .instance
          .collection('closed')
          .where('caseNo', isEqualTo: caseNumber)
          .get();

      for (var document in caseDetailsSnapshot1.docs) {
        String caseName = document['caseName'] ?? '';
        String partyName = document['partyName'] ?? '';

        Map<String, dynamic> caseDetailsData1 = {
          'caseName': caseName,
          'partyName': partyName,
        };

        // Merge case data and case details data into one map
        Map<String, dynamic> mergedData = {
          ...caseData,
          ...caseDetailsData1,
        };

        // Replace the item in the list with the merged data
        data[i] = mergedData;
      }
      final QuerySnapshot caseDetailsSnapshot2 = await FirebaseFirestore
          .instance
          .collection('upcoming')
          .where('caseNo', isEqualTo: caseNumber)
          .get();

      for (var document in caseDetailsSnapshot2.docs) {
        String caseName = document['caseName'] ?? '';
        String partyName = document['partyName'] ?? '';

        Map<String, dynamic> caseDetailsData2 = {
          'caseName': caseName,
          'partyName': partyName,
        };

        // Merge case data and case details data into one map
        Map<String, dynamic> mergedData = {
          ...caseData,
          ...caseDetailsData2,
        };

        // Replace the item in the list with the merged data
        data[i] = mergedData;
      }
    }

    // Add lawyer details
    final DocumentSnapshot lawyerSnapshot = await FirebaseFirestore.instance
        .collection('lawyers')
        .doc(lawyerId)
        .get();

    if (lawyerSnapshot.exists) {
      String lawyerName = lawyerSnapshot['name'] ?? '';
      String lawyerEmail = lawyerSnapshot['email'] ?? '';
      String lawyerPhoneNumber = lawyerSnapshot['mobileNumber'] ?? '';
      String lawyerId = lawyerSnapshot['lawyerId'] ?? '';

      Map<String, dynamic> lawyerData = {
        'lawyerName': lawyerName,
        'lawyerId': lawyerId,
        'lawyerEmail': lawyerEmail,
        'lawyerPhoneNumber': lawyerPhoneNumber,
      };

      for (int i = 0; i < data.length; i++) {
        // Merge lawyer data with each case data
        Map<String, dynamic> mergedData = {
          ...data[i],
          ...lawyerData,
        };

        // Replace the item in the list with the merged data
        data[i] = mergedData;
      }
    }

    setState(() {
      fileData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Transform(
                transform: Matrix4.translationValues(0, 10, 0),
                child: const Text(
                  "JURIDENT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffC99F4A),
                    fontSize: 30,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(-130, 25, 0),
                child: const Text(
                  "My Files",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffC99F4A),
                    fontSize: 26,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Container(
                height: 101,
                width: size.width,
                decoration: const ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFFAFAFA), width: 0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(30, 30, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BookmarksPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fixedSize: const Size(127, 38),
                                backgroundColor: const Color(0xFFC99F4A)),
                            child: Row(
                              children: [
                                Image.asset("assets/images/bookmark.png"),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  'Bookmarks',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 60),
                        Transform(
                          transform: Matrix4.translationValues(10, 30, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(90, 38),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: const Color(0xFFC99F4A),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Image.asset("assets/images/filter.png"),
                                const SizedBox(width: 6),
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(15, 30, 0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(90, 38),
                                backgroundColor: const Color(0xFFC99F4A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: Row(
                              children: [
                                Image.asset("assets/images/sort.png"),
                                const SizedBox(width: 6),
                                const Text(
                                  'Sort',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (fileData.isEmpty)
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Image.asset(
                        "assets/images/nofiles.png",
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'No Files',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'You have not added any files yet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(127, 38),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color(0xFFC99F4A),
                        ),
                        child: const Text(
                          'Add Files',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else if (fileData.isNotEmpty)
                Container(
                  width: 428,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 17);
                    },
                    itemCount: fileData.length,
                    itemBuilder: (context, index) {
                      final userData = fileData[index];
                      final casename = userData['caseName'] ?? '';
                      final casenumber = userData['caseNo'] ?? '';
                      final partyname = userData['partyName'] ?? '';
                      final lawyername = userData['lawyerName'] ?? '';
                      final lawyerId = userData['lawyerId'] ?? '';
                      final lawyeremail = userData['lawyerEmail'] ?? '';
                      final lawyerphonenumber =
                          userData['lawyerPhoneNumber'] ?? '';
                      final filename = userData['fileName'] ?? '';
                      final fileurl = userData['fileUrl'] ?? '';
                      return SharedfileWidget(
                        caseName: casename,
                        lawyerName: lawyername,
                        lawyerId: lawyerId,
                        lawyerPhoneNumber: lawyerphonenumber,
                        lawyerEmail: lawyeremail,
                        caseNo: casenumber,
                        partyName: partyname,
                        fileName: filename,
                        fileUrl: fileurl,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
