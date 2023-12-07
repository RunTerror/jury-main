import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/hamburgerMenu/hamburgerIcon.dart';
import 'package:juridentt/internship_provider.dart';
import 'package:juridentt/provider1.dart';
import 'package:provider/provider.dart';
import '../addcase/provider.dart';

class EditProfile extends StatefulWidget {
  static const String routename = '/EditProfile';
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User? user = FirebaseAuth.instance.currentUser;
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

  String? profile;
  bool _isEmailValid = true;
  void _validateEmail(String email) {
    bool isValid = RegExp(
            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(email);
    setState(() {
      _isEmailValid = isValid;
    });
  }

  String? degree;

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   _name.dispose();
  //   _ID.dispose();
  //   _degree.dispose();
  //   _email.dispose();
  //   _phone.dispose();
  //   _password.dispose();
  //   super.dispose();
  // }

  bool isExpanded = false;

  void toggleExpansion() {
    isExpanded = !isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ip = Provider.of<InternShipProvider>(context);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: themeProvider.hamcontainer,
            drawer: const HamburgerIcon(),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              backgroundColor: themeProvider.hamcontainer,
              title: const Text(
                "Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
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
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
            body: Consumer<UserProvider>(
              builder: (context, userinfo, child) {
                _name.text = userProvider.user.name;
                _email.text = userProvider.user.email;
                _ID.text = userProvider.user.lawyerId;
                _phone.text = userProvider.user.mobileNumber;
                return SingleChildScrollView(
                    child: Column(children: [
                  Stack(children: [
                    Container(
                        margin: EdgeInsets.only(top: height / 7),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: FocusScope(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () {
                                    _showSelectionDialog(context, ip);
                                  },
                                  child: Container(
                                    width: width,
                                    alignment: Alignment.center,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color: themeProvider.hamcontainer),
                                      height: 40,
                                      width: width / 2.2,
                                      child: const Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Lawyer Name",
                                  style: TextStyle(
                                      color: themeProvider.hamcontainer,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                _customTextField(context, _name),
                                Text(
                                  "Lawyer ID",
                                  style: TextStyle(
                                      color: themeProvider.hamcontainer,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                _customTextField(context, _ID),
                                Text(
                                  "Law Degree",
                                  style: TextStyle(
                                      color: themeProvider.hamcontainer,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(0)),
                                      border: Border.all(width: 1)),
                                  child: ExpansionTile(
                                    title: Text(degree ?? 'Chose your degree'),
                                    children: [
                                      ListTile(
                                        title: const Text('B.Sc.LLB'),
                                        onTap: () {
                                          setState(() {
                                            degree = 'B.Sc.LLB';
                                          });
                                          toggleExpansion();
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('BBA.LLB'),
                                        onTap: () {
                                          toggleExpansion();
                                          setState(() {
                                            degree = 'BBA.LLB';
                                          });
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('B.Com.LLB'),
                                        onTap: () {
                                          degree = 'B.Com.LLB';
                                          setState(() {});
                                          toggleExpansion();
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('B.A.LLB'),
                                        onTap: () {
                                          degree = 'B.A.LLB';
                                          setState(() {});
                                          toggleExpansion();
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('Other'),
                                        onTap: () {
                                          setState(() {
                                            degree = 'Other';
                                          });
                                          toggleExpansion();
                                        },
                                      ),
                                    ],
                                    onExpansionChanged: (value) {
                                      // degree != null ? value = false : null;
                                      toggleExpansion();
                                    },
                                  ),
                                ),
                                // Additional content below the expandable list
                                // if (!_isExpanded)
                                //   ListTile(
                                //     title: Text('Other Item'),
                                //     onTap: () {
                                //       // Handle item click
                                //       print('Other Item clicked');
                                //     },
                                //   ),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      color: themeProvider.hamcontainer,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                _customTextField(context, _email),
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      color: themeProvider.hamcontainer,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                _customTextField(context, _phone),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      color: themeProvider.hamcontainer,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                _customTextField(context, _password),
                                TextButton(
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
                                      width: width,
                                      alignment: Alignment.center,
                                      child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: width / 2),
                                          alignment: Alignment.center,
                                          height: height * 0.07,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                width: 1,
                                                  color: Colors.black)),
                                          child: const Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 12),
                                                child: Text(
                                                  "Change Password",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 12),
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Color(0xFFC99F4A),
                                                ),
                                              )
                                            ],
                                          )),
                                    )),
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: TextButton(
                                      onPressed: () async {
                                        //  var firebaseUser = await FirebaseAuth.instance.currentUser!;
                                        final updateRef = FirebaseFirestore
                                            .instance
                                            .collection("profile")
                                            .doc(user!.uid);
                                        if (!_isEmailValid) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Not a valid email format'),
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
                                          content: Text(
                                              'Changes saved successfully'),
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 2),
                                        ));
                                      },
                                      child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: width / 2),
                                          alignment: Alignment.center,
                                          height: height * 0.07,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                width: 1,
                                                  color: Colors.black)),
                                          child:  Text(
                                            "Save Changes",
                                            style: TextStyle(
                                                color: Constants.yellow,
                                                fontSize: 16),
                                          )),
                                    ),
                                ),
                                const SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        )),
                    Positioned(
                      left: width/2-60,
                      top: 35,
                      child: InkWell(
                        onTap: () {
                          _showSelectionDialog(context, ip);
                        },
                        child: Container(
                          // Set the height and width to maintain a circular shape
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: ip.profile != null
                                  ? Image(
                                      image: FileImage(ip.profile!),
                                      fit: BoxFit.cover,
                                    )
                                  : userinfo.user.profile.isEmpty
                                      ? Image.network(
                                          "https://picsum.photos/id/237/200/300",
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: userinfo.user.profile,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])
                ]));
              },
            )));
  }

  Widget _customTextField(
      BuildContext context, TextEditingController controller) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: themeProvider.hamcontainer),
        decoration: const InputDecoration(
          suffixIcon: Icon(
            Icons.edit,
            color: Color(0xFFC99F4A),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 30),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black)),
        ),
      ),
    );
  }

  Future<void> _showSelectionDialog(
      BuildContext context, InternShipProvider ip) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Slect image location'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.photo),
                      onTap: () {
                        ip.uploadImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      title: const Text('Gallery'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo),
                      onTap: () {
                        ip.uploadImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      title: const Text('Camera'),
                    ),
                  ],
                ),
              ));
        });
  }
}
