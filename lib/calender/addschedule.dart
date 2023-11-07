//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class AddSchedule extends StatefulWidget {
//   const AddSchedule({Key? key}) : super(key: key);
//
//   @override
//   State<AddSchedule> createState() => _InsertDataState();
// }
//
// class _InsertDataState extends State<AddSchedule> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final userNameController = TextEditingController();
//   TextEditingController _dateController = TextEditingController();
//   TextEditingController _timeController = TextEditingController();
//   late TimeOfDay _selectedTime;
//   late DateTime _selectedDate;
//   late CollectionReference users;
//
//   @override
//   void initState() {
//     super.initState();
//     users = FirebaseFirestore.instance.collection('users');
//   }
//
//   @override
//   void dispose() {
//     _dateController.dispose();
//     _timeController.dispose();
//     super.dispose();
//   }
//
//   String? _validateName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please fill the details';
//     }
//     if (value.length > 20) {
//       return 'Name should be less than 20 characters';
//     }
//     return null;
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//
//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//         _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
//       });
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (picked != null) {
//       setState(() {
//         _selectedTime = picked;
//         _timeController.text = _selectedTime.format(context);
//       });
//     }
//   }
//
//   Future<void> _validateAndSave() async {
//     final form = _formKey.currentState;
//     if (form != null && form.validate()) {
//       form.save();
//
//       await users.add({
//         'name': userNameController.text,
//         'date': _dateController.text,
//         'time': _timeController.text,
//       }).then((value) => print('User added'));
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Data added successfully')),
//       );
//
//       form.reset();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text('Inserting data'),
//       ),
//       body: ListView(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 50),
//                     const Text(
//                       'Add Schedule',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       controller: userNameController,
//                       keyboardType: TextInputType.text,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Name',
//                         hintText: 'Enter Your Name',
//                       ),
//                       validator: _validateName,
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       controller: _dateController,
//                       readOnly: true,
//                       onTap: () => _selectDate(context),
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Date',
//                         hintText: 'Select a date',
//                       ),
//                       validator: _validateName,
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       controller: _timeController,
//                       readOnly: true,
//                       onTap: () => _selectTime(context),
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Time',
//                         hintText: 'Select a time',
//                       ),
//                       validator: _validateName,
//                     ),
//                     const SizedBox(height: 30),
//                     MaterialButton(
//                       onPressed: _validateAndSave,
//                       child: const Text('Add'),
//                       color: const Color(0xFFC99F4A),
//                       textColor: Colors.white,
//                       minWidth: 200,
//                       height: 40,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// with the new variables

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import '../provider1.dart';
//
// class AddSchedule extends StatefulWidget {
//   const AddSchedule({Key? key}) : super(key: key);
//
//   @override
//   State<AddSchedule> createState() => _InsertDataState();
// }
//
// class _InsertDataState extends State<AddSchedule> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final userNameController = TextEditingController();
//   TextEditingController _dateController = TextEditingController();
//   TextEditingController _timeController = TextEditingController();
//   TextEditingController _date1Controller = TextEditingController(); // Add _date1Controller
//   late TimeOfDay _selectedTime;
//   late DateTime _selectedDate;
//   late CollectionReference users;
//
//   @override
//   void initState() {
//     super.initState();
//     print(Provider.of<UserProvider>(context, listen: false).user.mobileNumber);
//     users = FirebaseFirestore.instance.collection('events');
//     _date1Controller = TextEditingController(); // Initialize _date1Controller
//   }
//
//   @override
//   void dispose() {
//     _dateController.dispose();
//     _timeController.dispose();
//     _date1Controller.dispose(); // Dispose _date1Controller
//     super.dispose();
//   }
//
//   String? _validateName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please fill the details';
//     }
//     if (value.length > 20) {
//       return 'Name should be less than 20 characters';
//     }
//     return null;
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//
//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//         _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
//       });
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (picked != null) {
//       setState(() {
//         _selectedTime = picked;
//         _timeController.text = _selectedTime.format(context);
//
//         // Calculate milliseconds since epoch
//         final now = DateTime.now();
//         final dateTime = DateTime(
//           now.year,
//           now.month,
//           now.day,
//           _selectedTime.hour,
//           _selectedTime.minute,
//         );
//         final millisecondsSinceEpoch = dateTime.millisecondsSinceEpoch;
//         _date1Controller.text = millisecondsSinceEpoch.toString();
//       });
//     }
//   }
//
//   Future<void> _validateAndSave() async {
//     final form = _formKey.currentState;
//     if (form != null && form.validate()) {
//       form.save();
//
//       String? fcmToken1 = await FirebaseMessaging.instance.getToken();
//
//
//       await users.add({
//         'title': userNameController.text,
//         'date': _dateController.text,
//         'time': _timeController.text,
//         'time1':int.parse( _date1Controller.text), // Add date1 field
//         'fcmToken': fcmToken1,
//         "mobile": Provider.of<UserProvider>(context,listen: false).user.mobileNumber,
//
//       }).then((value) => print('User added'));
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Data added successfully')),
//       );
//
//       form.reset();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text('Inserting data'),
//       ),
//       body: ListView(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 50),
//                     const Text(
//                       'Add Schedule',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       controller: userNameController,
//                       keyboardType: TextInputType.text,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Name',
//                         hintText: 'Enter Your Name',
//                       ),
//                       validator: _validateName,
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       controller: _dateController,
//                       readOnly: true,
//                       onTap: () => _selectDate(context),
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Date',
//                         hintText: 'Select a date',
//                       ),
//                       validator: _validateName,
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       controller: _timeController,
//                       readOnly: true,
//                       onTap: () => _selectTime(context),
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Time',
//                         hintText: 'Select a time',
//                       ),
//                       validator: _validateName,
//                     ),
//                     const SizedBox(height: 30),
//                     MaterialButton(
//                       onPressed: _validateAndSave,
//                       child: const Text('Add'),
//                       color: const Color(0xFFC99F4A),
//                       textColor: Colors.white,
//                       minWidth: 200,
//                       height: 40,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider1.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _InsertDataState();
}

class _InsertDataState extends State<AddSchedule> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  TextEditingController _date1Controller = TextEditingController();
  late TimeOfDay _selectedTime;
  late DateTime _selectedDate;
  late CollectionReference users;
  String? _selectedDropdownValue;
  List<String> _dropdownData = [];

  @override
  void initState() {
    super.initState();
    print(Provider.of<UserProvider>(context, listen: false).user.mobileNumber);
    users = FirebaseFirestore.instance.collection('events');
    _date1Controller = TextEditingController();
    _fetchDropdownData();
  }

  // Future<void> _fetchDropdownData() async {
  //   QuerySnapshot snapshot =
  //   await FirebaseFirestore.instance.collection('upcoming').get();
  //   setState(() {
  //     _dropdownData = snapshot.docs.map((doc) => doc['caseNo']).toList();
  //   });
  // }
  Future<void> _fetchDropdownData() async {
    QuerySnapshot upcomingSnapshot =
        await FirebaseFirestore.instance.collection('upcoming').get();
    QuerySnapshot openSnapshot =
        await FirebaseFirestore.instance.collection('open').get();

    List<String> upcomingData =
        upcomingSnapshot.docs.map((doc) => doc['caseNo'].toString()).toList();
    List<String> openData =
        openSnapshot.docs.map((doc) => doc['caseNo'].toString()).toList();

    setState(() {
      _dropdownData = [...upcomingData, ...openData];
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _date1Controller.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill the details';
    }
    if (value.length > 20) {
      return 'Name should be less than 20 characters';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _selectedTime.format(context);

        final now = DateTime.now();
        final dateTime = DateTime(
          now.year,
          now.month,
          now.day,
          _selectedTime.hour,
          _selectedTime.minute,
        );
        final millisecondsSinceEpoch = dateTime.millisecondsSinceEpoch;
        _date1Controller.text = millisecondsSinceEpoch.toString();
      });
    }
  }

  Future<void> _validateAndSave() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      String? fcmToken1 = await FirebaseMessaging.instance.getToken();

      await users.add({
        'title': userNameController.text,
        'date': _dateController.text,
        'time': _timeController.text,
        'time1': int.parse(_date1Controller.text),
        'fcmToken': fcmToken1,
        'mobile':
            Provider.of<UserProvider>(context, listen: false).user.mobileNumber,
        'Case No': _selectedDropdownValue,
      }).then((value) => print('User added'));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data added successfully')),
      );

      form.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Inserting data'),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      'Add Schedule',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    TextFormField(
                      controller: userNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Your Name',
                      ),
                      validator: _validateName,
                    ),
                    SizedBox(height: 30.h),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date',
                        hintText: 'Select a date',
                      ),
                      validator: _validateName,
                    ),
                    SizedBox(height: 30.h),
                    TextFormField(
                      controller: _timeController,
                      readOnly: true,
                      onTap: () => _selectTime(context),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Time',
                        hintText: 'Select a time',
                      ),
                      validator: _validateName,
                    ),
                    SizedBox(height: 30.h),
                    DropdownButtonFormField<String>(
                      value: _selectedDropdownValue,
                      items: _dropdownData.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDropdownValue = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Case No',
                        hintText: 'Select a value',
                      ),
                      validator: _validateName,
                    ),
                    SizedBox(height: 30.h),
                    MaterialButton(
                      onPressed: _validateAndSave,
                      color: const Color(0xFFC99F4A),
                      textColor: Colors.white,
                      minWidth: 200.w,
                      height: 40.h,
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
