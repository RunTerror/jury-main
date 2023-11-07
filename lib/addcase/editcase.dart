// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/addcase/provider.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'editcasenotes.dart';

class EditCaseDetailsPage extends StatefulWidget {
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
  final String lawyerName;
  final Function(BuildContext, Map<String, dynamic>) onUpdate;

  const EditCaseDetailsPage({
    Key? key,
    required this.caseNumber,
    required this.caseName,
    required this.partyName,
    required this.courtName,
    required this.hearingDate,
    required this.partyContactNo,
    required this.adverseParty,
    required this.adversePartyContactNo,
    required this.adversePartyLawyer,
    required this.onUpdate,
    required this.caseType,
    required this.casenotes,
    required this.lawyerName,
  }) : super(key: key);

  @override
  State<EditCaseDetailsPage> createState() => _EditCaseDetailsPageState();
}

class _EditCaseDetailsPageState extends State<EditCaseDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _caseNameController = TextEditingController();
  final TextEditingController _caseNumberController = TextEditingController();
  final TextEditingController _courtNameController = TextEditingController();
  final TextEditingController _hearingDateController = TextEditingController();
  final TextEditingController _partyContactNoController =
      TextEditingController();
  final TextEditingController _adversePartyController = TextEditingController();
  final TextEditingController _adversePartyContactNoController =
      TextEditingController();
  final TextEditingController _adversePartyLawyerController =
      TextEditingController();
  final TextEditingController _casenotescontroller = TextEditingController();
  //String? _selectedCourt = '';

  @override
  void initState() {
    super.initState();
    _caseNumberController.text = widget.caseNumber;
    _caseNameController.text = widget.caseName;
    _courtNameController.text = widget.courtName;
    _hearingDateController.text = widget.hearingDate;
    _partyContactNoController.text = widget.partyContactNo;
    _adversePartyController.text = widget.adverseParty;
    _adversePartyContactNoController.text = widget.adversePartyContactNo;
    _adversePartyLawyerController.text = widget.adversePartyLawyer;
    _casenotescontroller.text = widget.casenotes;
  }

  @override
  void dispose() {
    _caseNumberController.dispose();
    _caseNameController.dispose();
    _courtNameController.dispose();
    _hearingDateController.dispose();
    _partyContactNoController.dispose();
    _adversePartyController.dispose();
    _adversePartyContactNoController.dispose();
    _adversePartyLawyerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final caseNotesProvider =
        Provider.of<CaseNotesProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.scaffoldcolor,
      body: Container(
        decoration:
            BoxDecoration(gradient: themeProvider.scaffoldGradientscrol),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(top: 50.h, bottom: 10.h, left: 16.w, right: 16.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  transform: Matrix4.translationValues(-120.w, 10, 0),
                  child: Text(
                    "Court Name",
                    style: TextStyle(
                      color: themeProvider.editext,
                      fontSize: 20.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 30.w, top: 30.h),
                  child: DropdownButtonFormField<String>(
                    // value: dropdownvalue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _courtNameController.text = newValue!;
                      });
                    },
                    value: _courtNameController.text,
                    items: <String>['highcourt', 'newcourt', 'supremecourt']
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
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeProvider.casestext),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(-120.w, 10, 0),
                  child: Text(
                    "Hearing Date",
                    style: TextStyle(
                      color: themeProvider.editext,
                      fontSize: 20.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 30.w, top: 30.h),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.edit),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeProvider.casestext,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                    controller: _hearingDateController,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData
                                .dark(), // Change the theme to dark for the date picker
                            child: child!,
                          );
                        },
                      ).then((pickedDate) {
                        if (pickedDate != null) {
                          // Format the selected date to exclude the time
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          _hearingDateController.text =
                              formattedDate; // Update the controller value with the formatted date
                        }
                      });
                    },
                  ),
                ),

                Container(
                  transform: Matrix4.translationValues(-80.w, 10, 0),
                  child: Text(
                    "Party Contact Number",
                    style: TextStyle(
                      color: themeProvider.editext,
                      fontSize: 20.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 30.w, top: 30.h),
                  child: TextField(
                    controller: _partyContactNoController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.edit),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: themeProvider.casestext,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                // TextFormField(
                //   controller: _partyContactNoController,
                //   decoration: InputDecoration(labelText: 'Party Contact No'),
                // ),
                Container(
                  transform: Matrix4.translationValues(-118.w, 10, 0),
                  child: Text(
                    "Adverse Party",
                    style: TextStyle(
                      color: themeProvider.editext,
                      fontSize: 20.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 30.w, top: 30.h),
                  child: TextField(
                    controller: _adversePartyController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.edit),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: themeProvider.casestext,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                // TextFormField(
                //   controller: _adversePartyController,
                //   decoration: InputDecoration(labelText: 'Adverse Party'),
                // ),
                Container(
                  transform: Matrix4.translationValues(-45.w, 13, 0),
                  child: Text(
                    "Adverse Party Contact Number",
                    style: TextStyle(
                      color: themeProvider.editext,
                      fontSize: 20.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 30.w, top: 30.h),
                  child: TextField(
                    controller: _adversePartyContactNoController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.edit),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: themeProvider.casestext,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                // TextFormField(
                // controller: _adversePartyContactNoController,
                //   decoration: InputDecoration(labelText: 'Adverse Party Contact No'),
                // ),
                Container(
                  transform: Matrix4.translationValues(-83.w, 10, 0),
                  child: Text(
                    "Adverse Party Lawyer",
                    style: TextStyle(
                      color: themeProvider.editext,
                      fontSize: 20.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 30.w, top: 30.h),
                  child: TextField(
                    controller: _adversePartyLawyerController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.edit),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: themeProvider.casestext,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                // TextFormField(
                // controller: _adversePartyLawyerController,
                //   decoration: InputDecoration(labelText: 'Adverse Party Lawyer'),
                // ),
                SizedBox(height: 16.0.h),
                ElevatedButton(
                  onPressed: () {
                    //   print('save button');
                    if (_formKey.currentState!.validate()) {
                      final Map<String, dynamic> updatedData = {
                        'caseNumber': _caseNumberController.text,
                        'caseName': _caseNameController.text,
                        'courtName': _courtNameController.text,
                        'hearingDate': _hearingDateController.text,
                        'partyContactNo': _partyContactNoController.text,
                        'adverseParty': _adversePartyController.text,
                        'adversePartyContactNo':
                            _adversePartyContactNoController.text,
                        'adversePartyLawyer':
                            _adversePartyLawyerController.text,
                        'casenotes': caseNotesProvider.casenotes,
                      };
                      //    print(_casenotescontroller.text);

                      // Call the onUpdate callback function with the updated data
                      widget.onUpdate(context, updatedData);
                    }
                  },
                  child: const Text('Save'),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Editcasenotes(
                        lawyerName: widget.lawyerName,
                        time: "2023-06-17 10:00 AM",
                        notes: widget.casenotes,
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 0, top: 20.h),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
