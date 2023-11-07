// ignore_for_file: use_wd_context_synchronously, use_key_in_widget_constructors, use_build_context_synchronously
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/addcase/provider.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/resources/file_upload.dart';
import 'package:juridentt/widgets/fileupload.dart';
import 'package:provider/provider.dart';
import '../models/userprovider.dart';
import 'app_datefield.dart';
import 'casenotes.dart';
import 'package:uuid/uuid.dart';

final uid = FirebaseAuth.instance.currentUser!.uid;

class CaseFormState extends ChangeNotifier {
  String caseNo = '';
  String caseName = '';
  String hearingDate = '';
  String courtName = '';
  String partyName = '';
  String partyContactNo = '';
  String adverseParty = '';
  String advocateNumber = '';
  String casetype = '';
  String casenotes = '';
  List<String> team = [];
  String get textFieldValue => casenotes;
  List<File> files = [];

  void updateCasenotes(String value) {
    casenotes = value;
    notifyListeners();
  }
}

// ignore: camel_case_types
class newcase_form extends StatefulWidget {
  @override
  State<newcase_form> createState() => _newcase_formContentState();
}

// ignore: camel_case_types
class _newcase_formContentState extends State<newcase_form> {
  late User? currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String dropdownvalue = 'highcourt';
  String law = '';
  String dropdownvalue1 = 'upcoming';
  String uid = '';
  String userName = FirebaseAuth.instance.currentUser!.displayName.toString();

  @override
  void initState() {
    super.initState();
    currentUser = auth.currentUser;
    uid = currentUser!.uid;
    initializeLawyerId();
  }

  void initializeLawyerId() async {
    String lawyerId = await fetchlawyerid();
    setState(() {
      law = lawyerId;
    });
  }

  void storeCaseData(CaseFormState caseData) {
    // add validation here

    if (caseData.caseNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter case number.'),
        ),
      );
      return;
    }

    if (caseData.caseName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter case name.'),
        ),
      );
      return;
    }

    if (caseData.hearingDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter hearing date.'),
        ),
      );
      return;
    }

    // if (caseData.courtName.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please enter court name.'),
    //     ),
    //   );
    //   return;
    // }

    if (caseData.partyName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter party name.'),
        ),
      );
      return;
    }

    if (caseData.partyContactNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter party contact number.'),
        ),
      );
      return;
    }

    if (caseData.adverseParty.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter adverse party.'),
        ),
      );
      return;
    }

    if (caseData.advocateNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter advocate number.'),
        ),
      );
      return;
    }

    // if (caseData.casetype.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please enter case type.'),
    //     ),
    //   );
    //   return;
    // }

    // if (caseData.casenotes.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please enter case notes.'),
    //     ),
    //   );
    //   return;
    // }

    // if (caseData.files.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please upload case files.'),
    //     ),
    //   );
    //   return;
    // }

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // add cases.
    caseData.team
        .clear(); // Clear the list if you want to ensure it only has one element
    caseData.team.add(law);
    caseData.courtName = dropdownvalue; // Add the 'law' value at the 0th index
    caseData.casetype = dropdownvalue1;

    try {
      for (var i = 0; i < caseData.files.length; i++) {
        String fileid = const Uuid().v1();
        FileStoreMethods().fileUpload(
          caseData.files[i],
          'lawyers',
          caseData.caseName,
          fileid,
          caseData.caseNo,
        );
      }
      firestore.collection(caseData.casetype).add({
        'caseNo': caseData.caseNo,
        'caseName': caseData.caseName,
        'hearingDate': caseData.hearingDate,
        'courtName': caseData.courtName,
        'partyName': caseData.partyName,
        'partyContactNo': caseData.partyContactNo,
        'adverseParty': caseData.adverseParty,
        'advocateNumber': caseData.advocateNumber,
        'casetype': caseData.casetype,
        'team': caseData.team,
        'casenotes': caseData.casenotes,
        'owner': uid
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Case added successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error adding case.'),
        ),
      );
    }
  }

  Future<String> fetchlawyerid() async {
    final user = FirebaseAuth.instance.currentUser;
    final userDoc =
        FirebaseFirestore.instance.collection('lawyers').doc(user!.uid);
    final userData = await userDoc.get();
    String law = userData['lawyerId'];
    return law;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userDetailProvider = Provider.of<UserDetailProvider>(context);
    userDetailProvider.fetchUserDetail();
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.scaffoldcolor,
        body: Container(
          decoration:
              BoxDecoration(gradient: themeProvider.scaffoldGradientscrol),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  transform: Matrix4.translationValues(130, 80, 0),
                  child: Text(
                    "JURIDENT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeProvider.darkopp,
                      fontSize: 30.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // Container(
                //   transform: Matrix4.translationValues(185, 80, 0),
                //   child: const Text(
                //     "ENT",
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 30,
                //       fontFamily: 'Satoshi',
                //       fontWeight: FontWeight.w500,
                //       fontStyle: FontStyle.normal,
                //     ),
                //   ),
                // ),
                // Transform(
                //   transform: Matrix4.translationValues(205, 160, 0),
                //   child: FilledButton(
                //       onPressed: () {},
                //       style: FilledButton.styleFrom(
                //           backgroundColor: Colors.grey.shade700),
                //       child: const Text(
                //         "Save as Draft",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 20,
                //           fontFamily: 'Satoshi',
                //           fontWeight: FontWeight.w500,
                //           fontStyle: FontStyle.normal,
                //         ),
                //       )),
                // ),
                Container(
                  transform: Matrix4.translationValues(30, 80, 0),
                  child: Text(
                    "Add case",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 90.h),
                  child: Column(
                    children: [
                      Container(
                        transform: Matrix4.translationValues(-130, 30, 0),
                        child: Text(
                          "Case No",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 28.w, right: 30.w, top: 50.h),
                        child: TextField(
                          onChanged: (value) {
                            Provider.of<CaseFormState>(context, listen: false)
                                .caseNo = value;
                          },
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(-120, 30, 0),
                        child: Text(
                          "Case Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 28.w, right: 30.w, top: 50.h),
                        child: TextField(
                          onChanged: (value) {
                            Provider.of<CaseFormState>(context, listen: false)
                                .caseName = value;
                          },
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      AppTextFieldWithDatePicker(
                        title: "Hearing Date",
                        onChanged: (value) {
                          Provider.of<CaseFormState>(context, listen: false)
                              .hearingDate = value;
                        },
                        focusNode: FocusNode(),
                        onEditingComplete: () {},
                      ),
                      Container(
                        transform: Matrix4.translationValues(-115, 30, 0),
                        child: Text(
                          "Court Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 28.w, right: 30.w, top: 50.h),
                        child: DropdownButtonFormField<String>(
                          value: dropdownvalue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                          items: <String>[
                            'highcourt',
                            'newcourt',
                            'supremecourt'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(-115, 30, 0),
                        child: Text(
                          "Party Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 28.w, right: 30.w, top: 50.h),
                        child: TextField(
                          onChanged: (value) {
                            Provider.of<CaseFormState>(context, listen: false)
                                .partyName = value;
                          },
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(-90, 30, 0),
                        child: Text(
                          "Party Contact No",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 28.w, right: 30.w, top: 50.h),
                        child: TextField(
                          onChanged: (value) {
                            Provider.of<CaseFormState>(context, listen: false)
                                .partyContactNo = value;
                          },
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(-105, 30, 0),
                        child: Text(
                          "Adverse Party",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 28.w, right: 30.w, top: 50.h),
                        child: TextField(
                          onChanged: (value) {
                            Provider.of<CaseFormState>(context, listen: false)
                                .adverseParty = value;
                          },
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(-88, 30, 0),
                        child: Text(
                          "Advocate Number",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 28.w, right: 30.w, top: 50.h),
                        child: TextField(
                          onChanged: (value) {
                            Provider.of<CaseFormState>(context, listen: false)
                                .advocateNumber = value;
                          },
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(-125, 30, 0),
                        child: Text(
                          "Case Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 28.w, right: 30.w, top: 50.h),
                        child: DropdownButtonFormField<String>(
                          value: dropdownvalue1,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue1 = newValue!;
                            });
                          },
                          items: <String>['upcoming', 'open', 'closed']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
                AppFilePicker(
                  title: "Case File Upload",
                  onFilesSelected: (file) async {
                    final caseFormState =
                        Provider.of<CaseFormState>(context, listen: false);
                    caseFormState.files = file;
                  },
                  buttonText: "Upload Files",
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, '/filedownload');
                //   },
                //   child: Container(
                //     margin: const EdgeInsets.only(left: 100),
                //     width: 174,
                //     decoration: BoxDecoration(
                //       color: const Color(0xffFFEABE),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: const Padding(
                //       padding: EdgeInsets.all(16.0),
                //       child: Text(
                //         'Download Files',
                //         style: TextStyle(
                //           fontSize: 16,
                //           color: Colors.black,
                //         ),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => CustomeCaseNotes(
                        // lawyerName: "John Doe",
                        lawyerName: userDetailProvider.userDetail!.displayName,
                        // time: "2023-06-17 10:00 AM",
                        time: DateTime.now().toString(),
                        notes:
                            Provider.of<CaseFormState>(context, listen: false)
                                .casenotes,
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 130.w),
                    width: 174.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFEABE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Add case notes',
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
                    final caseFormState =
                        Provider.of<CaseFormState>(context, listen: false);
                    storeCaseData(caseFormState);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 130.w),
                    width: 174.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFEABE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'submit',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
