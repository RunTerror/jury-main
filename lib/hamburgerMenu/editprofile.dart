import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../addcase/provider.dart';
import 'package:country_flags/country_flags.dart';

class EditProfile extends StatefulWidget {
  static const String routename = '/EditProfile';
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("profile");
  // final _updateRef = _collectionReference.doc('6hNR1OdhqR6lD96zNw0Q');
  final TextEditingController _name = TextEditingController();
  final TextEditingController _ID = TextEditingController();
  final TextEditingController _degree = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  final FocusNode _idFocus = FocusNode();
  final FocusNode _degreeFocus = FocusNode();

  final FocusNode _emailFocus = FocusNode();

  final FocusNode _phoneFocus = FocusNode();

  late Stream<QuerySnapshot> collectionItem;
  // AuthService authService=AuthService();
  // var firebaseUser =  FirebaseAuth.instance.currentUser!();
  bool _isEmailValid = true;
  void _validateEmail(String email) {
    bool isValid = RegExp(
            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(email);
    setState(() {
      _isEmailValid = isValid;
    });
  }

  @override
  void initState() {
    super.initState();
    collectionItem = _collectionReference.snapshots();
    fetchInitialValueFromFirestore();
  }

  Future<void> fetchInitialValueFromFirestore() async {
    ;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    DocumentReference<Map<String, dynamic>> snapshot =
        firestore.collection('lawyers').doc(uid);
    // Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    DocumentSnapshot<Map<String, dynamic>> data = await snapshot.get();
    String initialValue = data['name']?.toString() ?? '';
    String initialValue1 = data['lawyerId']?.toString() ?? '';
    // String initialValue2 = data['degree']?.toString() ?? '';
    String initialValue2 = '';
    String initialValue3 = data['mobileNumber']?.toString() ?? '';
    String initialValue4 = data['email']?.toString() ?? '';
    // String initialValue5 = data['password']?.toString() ?? '';
    String initialValue5 = '';
    print(
        'initialValue: $initialValue, $initialValue1, $initialValue2, $initialValue3, $initialValue4, $initialValue5');
    // if (snapshot) {
    setState(() {
      _name.text = initialValue;
      _ID.text = initialValue1;
      _degree.text = initialValue2;
      _phone.text = initialValue3;
      _email.text = initialValue4;
      _password.text = initialValue5;
    });
    // }
  }

  @override
  void dispose() {
    _name.dispose();
    _ID.dispose();
    _degree.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    _collectionReference.get();
    _collectionReference.snapshots();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
            // drawer: HamburgerIcon(),
            appBar: AppBar(
              iconTheme:
                  IconThemeData(color: themeProvider.darkModeButtonColor),
              centerTitle: true,
              backgroundColor: themeProvider.opphamcontainer,
              // leading: InkWell(
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: ((context) => HamburgerIcon())));
              //   },
              //   child: Icon(
              //     Icons.menu,
              //     color: Color(0xFFC99F4A),

              //   ),
              // ),
              title: const Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFC99F4A),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: Container(
                        width: 35,
                        decoration: BoxDecoration(
                          // color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xFFC99F4A),
                        )),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Stack(children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.13),
                  child: Container(
                      height: height * 0.81,
                      width: width,
                      decoration: BoxDecoration(
                          color: themeProvider.skipButtonColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: SingleChildScrollView(
                            child: FocusScope(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.08,
                                    top: height * 0.03,
                                    right: width * 0.6),
                                child: Text(
                                  "Lawyer Name",
                                  style: TextStyle(
                                      color: themeProvider.notesbackground,
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
                                      hintColor: themeProvider.notesbackground),
                                  child: TextFormField(
                                    // onFieldSubmitted: (value){
                                    //   FocusScope.of(context).unfocus();

                                    // },
                                    controller: _name,

                                    style: TextStyle(
                                        color: themeProvider.notesbackground),

                                    // keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      suffixIcon: const Icon(
                                        Icons.edit,
                                        color: Color(0xFFC99F4A),
                                      ),

                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 9, horizontal: 30),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: themeProvider
                                                  .notesbackground)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: themeProvider
                                                  .notesbackground)),
                                      // labelText: document['name'],
                                      // floatingLabelBehavior: FloatingLabelBehavior.always
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.08,
                                    top: height * 0.015,
                                    right: width * 0.6),
                                child: Text(
                                  "Lawyer ID",
                                  style: TextStyle(
                                      color: themeProvider.notesbackground,
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
                                    hintColor: Colors.white,
                                  ),
                                  child: TextFormField(
                                    controller: _ID,
                                    focusNode: _idFocus,
                                    // onFieldSubmitted: (value){
                                    //   FocusScope.of(context).unfocus();
                                    // },
                                    // initialValue: document['ID'],
                                    style: TextStyle(
                                        color: themeProvider.notesbackground),

                                    // keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      suffixIcon: const Icon(
                                        Icons.edit,
                                        color: Color(0xFFC99F4A),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 9, horizontal: 30),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: themeProvider
                                                  .notesbackground)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: themeProvider
                                                  .notesbackground)),
                                      // labelText: "Confirm Password",
                                      // floatingLabelBehavior: FloatingLabelBehavior.always
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.08,
                                    top: height * 0.015,
                                    right: width * 0.6),
                                child: Text(
                                  "Law Degree",
                                  style: TextStyle(
                                      color: themeProvider.notesbackground,
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
                                  data: ThemeData(hintColor: Colors.white),
                                  child: TextFormField(
                                    // onFieldSubmitted: (value){
                                    //   FocusScope.of(context).unfocus();
                                    // },
                                    focusNode: _degreeFocus,
                                    controller: _degree,
                                    // initialValue: document['Degree'],
                                    style: TextStyle(
                                        color: themeProvider.notesbackground),

                                    // keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFFC99F4A),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 9, horizontal: 30),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: themeProvider
                                                    .notesbackground)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: themeProvider
                                                    .notesbackground)),
                                        // labelText: "Confirm Password",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.08,
                                    top: height * 0.015,
                                    right: width * 0.6),
                                child: Text(
                                  "Email",
                                  style: TextStyle(
                                      color: themeProvider.notesbackground,
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
                                  data: ThemeData(hintColor: Colors.white),
                                  child: TextFormField(
                                    onChanged: _validateEmail,
                                    // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$'))],
                                    // onFieldSubmitted: (value){
                                    //   FocusScope.of(context).unfocus();
                                    // },
                                    focusNode: _emailFocus,
                                    controller: _email,
                                    // initialValue: document['email'],
                                    style: TextStyle(
                                        color: themeProvider.notesbackground),

                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                          Icons.edit,
                                          color: Color(0xFFC99F4A),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 9, horizontal: 30),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: themeProvider
                                                    .notesbackground)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: themeProvider
                                                    .notesbackground)),
                                        // labelText: "Confirm Password",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.08,
                                    top: height * 0.015,
                                    right: width * 0.6),
                                child: Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      color: themeProvider.notesbackground,
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
                                  data: ThemeData(hintColor: Colors.white),
                                  child: TextFormField(
                                    focusNode: _phoneFocus,
                                    // onFieldSubmitted: (value){
                                    //   FocusScope.of(context).unfocus();
                                    // },
                                    controller: _phone,
                                    // initialValue: document['phone'],
                                    style: TextStyle(
                                        color: themeProvider.notesbackground),
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7.0, right: 7),
                                          // child: Image.asset(
                                          //   'icons/flags/png/in.png',
                                          //   package: 'country_icons',
                                          //   width: 10,
                                          //   height: 5,
                                          // ),
                                          child: CountryFlag.fromCountryCode(
                                            'IN',
                                            height: 10,
                                            width: 5,
                                            borderRadius: 8,
                                          ),
                                        ),
                                        // prefixIcon: Icon,
                                        suffixIcon: const Icon(
                                          Icons.edit,
                                          color: Color(0xFFC99F4A),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 9, horizontal: 30),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: themeProvider
                                                    .notesbackground)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: themeProvider
                                                    .notesbackground)),
                                        // labelText: "Confirm Password",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.08,
                                    top: height * 0.015,
                                    right: width * 0.6),
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                      color: themeProvider.notesbackground,
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
                                  data: ThemeData(hintColor: Colors.white),
                                  child: TextFormField(
                                    focusNode: _focusNode,
                                    controller: _password,
                                    obscureText: true,
                                    // initialValue: document['phone'],
                                    style: TextStyle(
                                        color: themeProvider.notesbackground),
                                    // keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        // prefixIcon: Icon,
                                        suffixIcon: const Icon(
                                          Icons.edit,
                                          color: Color(0xFFC99F4A),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 9, horizontal: 30),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: themeProvider
                                                    .notesbackground)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: themeProvider
                                                    .notesbackground)),
                                        // labelText: "Confirm Password",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.17,
                                    right: width * 0.2),
                                child: TextButton(
                                    onPressed: () async {
                                      // var firebaseUser = await FirebaseAuth.instance.currentUser!;
                                      final updateRef = FirebaseFirestore
                                          .instance
                                          .collection("profile")
                                          .doc(user!.uid);
                                      if (_password.text.length < 8) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'Password should have a length of 8'),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                      updateRef.update({
                                        'password': _password.text,
                                      });
                                      _focusNode.unfocus();
                                    },
                                    child: Container(
                                        height: height * 0.07,
                                        width: width * 0.6,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: const Row(
                                          children: [
                                            SizedBox(
                                              width: 17,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                "Change Password",
                                                style: TextStyle(
                                                    color: Color(0xFFC99F4A),
                                                    fontSize: 16),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Icon(
                                              Icons.arrow_circle_right,
                                              color: Color(0xFFC99F4A),
                                            )
                                          ],
                                        ))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.001,
                                    left: width * 0.17,
                                    right: width * 0.2),
                                child: TextButton(
                                    onPressed: () async {
                                      //  var firebaseUser = await FirebaseAuth.instance.currentUser!;
                                      final updateRef = FirebaseFirestore
                                          .instance
                                          .collection("profile")
                                          .doc(user!.uid);
                                      if (_phone.text.length != 13) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Not a valid phone number'),
                                          backgroundColor: Colors.red,
                                        ));
                                      } else if (!_isEmailValid) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Not a valid email format'),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                      updateRef.update({
                                        'username': _name.text,
                                        'id': _ID.text,
                                        'phoneNumber': _phone.text,
                                        'email': user!.email,
                                        'degree': _degree.text,
                                        'uid': user!.uid
                                      });
                                      _nameFocus.unfocus();
                                      _idFocus.unfocus();
                                      _degreeFocus.unfocus();
                                      _emailFocus.unfocus();
                                      _phoneFocus.unfocus();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text('Changes saved successfully'),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 2),
                                      ));
                                    },
                                    child: Container(
                                        height: height * 0.06,
                                        width: width * 0.6,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFC99F4A),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Center(
                                            child: Text(
                                          "Save Profile",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )))),
                              ),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        )),
                      )),
                ),
                Positioned(
                  top: height * 0.03,
                  left: width * 0.35,
                  right: width * 0.35,
                  bottom: height * 0.78,
                  child: Container(
                    height: height * 0.21,
                    width: width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.purple
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        "https://picsum.photos/id/237/200/300",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ])
            ]))));
  }
}
