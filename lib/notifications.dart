// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class newCases extends StatefulWidget {
  static const String routename = '/notifications';
  const newCases({super.key});

  @override
  State<newCases> createState() => _newCasesState();
}

class _newCasesState extends State<newCases> {
  // final myauth=EmailOTP();
  DateTime? selectedDate;
  final TextEditingController _name = TextEditingController();
  late final TextEditingController _time = TextEditingController();

  String _valueChanged1 = '';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';
  @override
  void initState() {
    // _time = TextEditingController(text: DateTime.now().toString());
    selectedDate = DateTime.now();
    super.initState();
  }
  //  final fcmToken= await FirebaseMessaging.instance.getToken();

  @override
  void dispose() {
    _name.dispose();
    _time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  String fcmToken = await FirebaseMessaging.instance.getToken();
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    Future<void> addUser() async {
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      return users.doc(_name.text.toString()).set({
        'name': _name.text.toString(),
        // 'id': _id.text.toString(),
        'fcmToken': fcmToken
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          backgroundColor: Colors.green,
          content: Text(
            "User registered successfully",
            style: TextStyle(color: Colors.white),
          ),
        ));
      }).catchError((error) {});
    }

    CollectionReference form = FirebaseFirestore.instance.collection("events");
    Future<void> addNote() {
      return form
          .add({
            'title': _name.text.toString(),
            'userId': _name.text.toString(),
            'time': selectedDate?.millisecondsSinceEpoch,
          })
          .then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(20),

                  // padding: EdgeInsets.all(20),
                  backgroundColor: Colors.green,
                  content: Text(
                    "Your note was recorded",
                    style: TextStyle(color: Colors.white),
                  ))))
          .catchError(
              (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(20),

                  // padding: EdgeInsets.all(20),
                  backgroundColor: Colors.green,
                  content: Text(
                    "The error was $error",
                    style: const TextStyle(color: Colors.white),
                  ))));
    }

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // drawer: HamburgerIcon(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: true ? Colors.black : Colors.white,
          title: const Text(
            "Notification",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                    width: 35,
                    decoration: BoxDecoration(
                      // color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                    )),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: Container(
                    height: height * 0.725,
                    width: width,
                    decoration: BoxDecoration(
                        color: true ? Colors.white : Colors.black,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: FocusScope(
                        child: ListView(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.08,
                                  top: height * 0.03,
                                  right: width * 0.6),
                              child: const Text(
                                "Name",
                                style: TextStyle(
                                    color: true ? Colors.black : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.08,
                                  right: width * 0.0467,
                                  top: height * 0.004),
                              child: Theme(
                                data: ThemeData(
                                    hintColor:
                                        true ? Colors.black : Colors.white),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _name,
                                  style: const TextStyle(
                                      color:
                                          true ? Colors.black : Colors.white),
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),

                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 30),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: true
                                                ? Colors.black
                                                : Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: true
                                                ? Colors.black
                                                : Colors.white)),
                                    // labelText: document['name'],
                                    // floatingLabelBehavior: FloatingLabelBehavior.always
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 17, top: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: DateTimePicker(
                                  type: DateTimePickerType.dateTimeSeparate,
                                  dateMask: 'd MMM, yyyy',
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  icon: const Icon(Icons.event),
                                  dateLabelText: 'Date',
                                  timeLabelText: "Hour",
                                  selectableDayPredicate: (date) {
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
                                      return false;
                                    }
                                    return true;
                                  },
                                  onChanged: (val) {
                                    // print(val);
                                    setState(() {
                                      _valueChanged1 = val;
                                      selectedDate = DateTime.parse(val);
                                      print(selectedDate);
                                    });
                                  },
                                  validator: (val) {
                                    setState(
                                        () => _valueToValidate1 = val ?? '');
                                    return null;
                                  },
                                  onSaved: (val) =>
                                      setState(() => _valueSaved1 = val ?? ''),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.01,
                                  left: width * 0.17,
                                  right: width * 0.2),
                              child: TextButton(
                                  onPressed: () {
                                    addNote();
                                    addUser();

                                    print(_name.text.toString());
                                    print(selectedDate);
                                  },
                                  child: Container(
                                      height: height * 0.06,
                                      width: width * 0.6,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Center(
                                          child: Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )))),
                            ),
                            TextButton(
                                onPressed: () {
                                  addUser();
                                },
                                child: const Text('Register user')),
                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
