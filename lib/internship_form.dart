import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/internship_provider.dart';
import 'package:provider/provider.dart';

class InternShipForm extends StatefulWidget {
  const InternShipForm({super.key});

  @override
  State<InternShipForm> createState() => _InternShipFormState();
}

class _InternShipFormState extends State<InternShipForm> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _lastname = TextEditingController();

  final TextEditingController _preferedName = TextEditingController();

  final TextEditingController _regNum = TextEditingController();

  final TextEditingController _departmentName = TextEditingController();

  final TextEditingController _fileofstudy = TextEditingController();

  final TextEditingController _cgpa = TextEditingController();

  final TextEditingController _promoCode = TextEditingController();

  final TextEditingController _subscription = TextEditingController();

  final TextEditingController _permanentAddress = TextEditingController();

  final TextEditingController _experience = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ip = Provider.of<InternShipProvider>(context);
    final theme = Theme.of(context);

    final h = MediaQuery.of(context).size.width;
    final w = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: Constants.lightblack,
          title: SizedBox(
            height: 80,
            child: Image.asset('assets/Group 33622.png'),
          )),
      backgroundColor: Constants.lightblack,
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Text(
              'Internship Form',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.blue,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: w / 4.8, child: customTextField(_name, 'Name')),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      width: w / 4.8,
                      child: customTextField(_lastname, 'last name'))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            customTextField(_preferedName, 'preffered name'),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  'College Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 25),
                ),
                Spacer()
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: w / 4.8,
                      child: customTextField(_regNum, 'Registration number')),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      width: w / 4.8,
                      child: customTextField(_departmentName, 'Department'))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: w / 4.8,
                      child: customTextField(_fileofstudy, 'File of study')),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      width: w / 4.8, child: customTextField(_cgpa, 'CGPA'))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            customTextField(_promoCode, 'Subscription code'),
            const SizedBox(
              height: 20,
            ),
            customTextField(_permanentAddress, 'permanent address'),
            const SizedBox(
              height: 20,
            ),
            customTextField(_experience, 'experience'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        ip.selectFile();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: ip.chosenfile == null
                            ? const Text('Upload Resume')
                            : const Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 40,
                              ),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: const Text('Upload Cover letter'),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () async {
                  if (_name.text.trim().isEmpty ||
                      _lastname.text.trim().isEmpty ||
                      _preferedName.text.trim().isEmpty ||
                      _regNum.text.trim().isEmpty ||
                      _departmentName.text.trim().isEmpty ||
                      _fileofstudy.text.trim().isEmpty ||
                      _cgpa.text.trim().isEmpty ||
                      _promoCode.text.trim().isEmpty ||
                      _permanentAddress.text.trim().isEmpty ||
                      _experience.text.trim().isEmpty ||
                      ip.chosenfile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please complete all the fields')));
                  } else {
                    try {
                      ip.uploadFile(
                          _name.text.trim(),
                          _lastname.text.trim(),
                          _preferedName.text.trim(),
                          _regNum.text.trim(),
                          _departmentName.text.trim(),
                          _fileofstudy.text.trim(),
                          _cgpa.text.trim(),
                          _promoCode.text.trim(),
                          _permanentAddress.text.trim(),
                          _experience.text.trim());
                    } catch (e) {
                      log(e.toString());
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white),
                  constraints: BoxConstraints(maxWidth: w / 1.8),
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text('Apply'),
                )),
            const SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController controller, String hintText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Constants.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: controller,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
        keyboardType: hintText == 'CGPA' || hintText == 'Registration number'
            ? TextInputType.number
            : null,
      ),
    );
  }
}
