// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/resources/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumberInputClient extends StatefulWidget {
  const PhoneNumberInputClient({Key? key}) : super(key: key);

  @override
  State<PhoneNumberInputClient> createState() => _PhoneNumberInputClientState();
}

class _PhoneNumberInputClientState extends State<PhoneNumberInputClient> {
  TextEditingController phoneNumber = TextEditingController();

  bool keepLoggedIn = true;

  final FocusNode _focusNode1 = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _focusNode1.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  void _loseFocus() {
    _focusNode1.unfocus();
  }

  void updatePhoneNumber() async {
    String res = await Auth().updatePhoneNumberClient(
      phoneNumber: phoneNumber.text,
    );
    if (res == 'success') {
      // Navigator.pushNamed(context, '/clienthomescreen');
      Navigator.pushNamed(context, '/clientsearchpage');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              res,
              textAlign: TextAlign.center,
              style: Constants.satoshiLightBlackNormal22,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: Constants.lightBlackBold,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/clientlogin');
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final height = size.height;
    // final width = size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(201, 159, 74, 0.54),
        backgroundColor: Constants.orange,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              const Image(
                image: AssetImage(
                  'assets/images/ellipse.png',
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 35.w, right: 35.w, top: 30.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Welcome to Jurident",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: Constants.satoshiYellowNormal22),
                      Container(
                        width: 358.w,
                        margin: EdgeInsets.only(top: 17.h),
                        child: Text(
                            "Are you ready to become a legal eagle? Login to the app and spread your wings in the courtroom.",
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            style: Constants.satoshiBlackNormal18),
                      ),
                      Container(
                        height: 464.w,
                        width: 440.h,
                        margin: EdgeInsets.only(top: 30.h),
                        padding: EdgeInsets.only(
                            left: 29.w, right: 20.w, bottom: 31.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Constants.white,
                          border: Border.all(
                            color: Constants.black33,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Constants.black4c,
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 250.h),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Log In",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: Constants
                                              .satoshiTransparentNormal22Underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/clientsignup');
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 28.w, bottom: 2.h),
                                      child: Text(
                                        "Sign Up",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style:
                                            Constants.satoshiLightBlackNormal22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -120.0, 0.0),
                              child: Text(
                                "Enter your phone number:",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: Constants.satoshiBlackNormal18,
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -100.0, 0.0),
                              child: TextFormField(
                                focusNode: _focusNode1,
                                onEditingComplete: _loseFocus,
                                controller: phoneNumber,
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  contentPadding: EdgeInsets.only(
                                    left: 10.w,
                                    top: 16.h,
                                    right: 7.w,
                                    bottom: 16.h,
                                  ),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(
                                      left: 10.w,
                                      top: 16.h,
                                      right: 7.w,
                                      bottom: 16.h,
                                    ),
                                    child: Icon(
                                      Icons.phone,
                                      color: Constants.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(
                                      color: Constants.black,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(
                                      color: Constants.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }

                                  // Regular expression for 10-digit number validation
                                  final numberRegex = RegExp(r'^\d{10}$');

                                  if (!numberRegex.hasMatch(value)) {
                                    return 'Please enter a valid 10-digit number';
                                  }

                                  return null; // Return null to indicate no validation errors
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                updatePhoneNumber();
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.lightblack,
                                minimumSize: const Size(320, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Submit",
                                style: Constants.satoshiWhite18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
