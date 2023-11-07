// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/resources/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  // Reset Password
  Future<void> sendPasswordResetEmail() async {
    try {
      await Auth().sendPasswordResetEmail(
        email: emailController.text,
      );
      _showDialog1();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Password reset'),
            content: const Text('No user found for that email.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.pushNamed(context, '/category');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showDialog1() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Password reset'),
        content:
            const Text('Password reset email sent , Check SPAM folder too.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _focusNode1 = FocusNode();

  @override
  void dispose() {
    _focusNode1.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _loseFocus() {
    _focusNode1.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Constants.orange,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_blue.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
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
                      padding:
                          EdgeInsets.only(left: 35.w, right: 35.w, top: 30.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to Jurident",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: Constants.satoshiYellowNormal22,
                          ),
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
                            height: 464.h,
                            width: 440.w,
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
                                // Padding(
                                //   padding: const EdgeInsets.only(bottom: 260),
                                //   child: Row(
                                //     children: [
                                //       Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         children: [
                                //           Align(
                                //             alignment: Alignment.center,
                                //             child: Text(
                                //               "Log In",
                                //               overflow: TextOverflow.ellipsis,
                                //               textAlign: TextAlign.left,
                                //               style: Constants
                                //                   .satoshiTransparentNormal22Underline,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       GestureDetector(
                                //         onTap: () {
                                //           Navigator.pushNamed(
                                //               context, '/signup');
                                //         },
                                //         child: Padding(
                                //           padding: const EdgeInsets.only(
                                //               left: 28, bottom: 2),
                                //           child: Text(
                                //             "Sign Up",
                                //             overflow: TextOverflow.ellipsis,
                                //             textAlign: TextAlign.left,
                                //             style: Constants
                                //                 .satoshiLightBlackNormal22,
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Container(
                                  transform: Matrix4.translationValues(
                                      0.0, -140.0, 0.0),
                                  child: Text(
                                    'Enter Your Email Address :',
                                    style: Constants.satoshiBlackNormal18,
                                  ),
                                ),
                                Container(
                                  transform: Matrix4.translationValues(
                                      0.0, -120.0, 0.0),
                                  child: TextFormField(
                                    focusNode: _focusNode1,
                                    onEditingComplete: _loseFocus,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText: "Email",
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
                                        child: Image.asset(
                                          'assets/images/mailsymbol.png',
                                          height: 20.h,
                                          width: 20.w,
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
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email address';
                                      }
                                      // Regular expression for email validation
                                      final emailRegex = RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                      if (!emailRegex.hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null; // Return null to indicate no validation errors
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                    }
                                    sendPasswordResetEmail();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.lightblack,
                                    minimumSize: const Size(320, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    "Send Reset Email",
                                    style: Constants.satoshiWhite18,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.lightblack,
                                    minimumSize: Size(320.w, 50.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    "Go Back",
                                    style: Constants.satoshiWhite18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     Padding(
                          //       padding:
                          //           const EdgeInsets.only(top: 20, bottom: 6),
                          //       child: SizedBox(
                          //         width: 149,
                          //         child: Divider(
                          //           height: 1,
                          //           thickness: 1,
                          //           color: Constants.black,
                          //         ),
                          //       ),
                          //     ),
                          //     const Padding(
                          //       padding: EdgeInsets.only(left: 7),
                          //       child: Text(
                          //         "or",
                          //         overflow: TextOverflow.ellipsis,
                          //         textAlign: TextAlign.left,
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding:
                          //           const EdgeInsets.only(top: 14, bottom: 6),
                          //       child: SizedBox(
                          //         width: 149,
                          //         child: Divider(
                          //           height: 1,
                          //           thickness: 1,
                          //           color: Constants.black,
                          //           indent: 10,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 5, left: 135),
                          //   child: Text(
                          //     "Log In with",
                          //     style: Constants.satoshiGrey90016,
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 13, bottom: 5),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       GestureDetector(
                          //         onTap: () {
                          //           Auth().signInWithFacebookClient(context);
                          //         },
                          //         child: Image.asset(
                          //           'assets/images/facebook_logo.png',
                          //           width: 45,
                          //           height: 45,
                          //         ),
                          //       ),
                          //       Container(
                          //         margin: const EdgeInsets.only(left: 50),
                          //         child: GestureDetector(
                          //           onTap: () {
                          //             Auth().signInWithGoogleClient(context);
                          //           },
                          //           child: Image.asset(
                          //             'assets/images/google_logo.png',
                          //             width: 48,
                          //             height: 48,
                          //           ),
                          //         ),
                          //       ),
                          //       Container(
                          //         margin: const EdgeInsets.only(
                          //             left: 50, top: 4, bottom: 4),
                          //         child: GestureDetector(
                          //           onTap: () {
                          //             Auth().signInWithTwitterClients(context);
                          //           },
                          //           child: Image.asset(
                          //             'assets/images/twitter_logo.png',
                          //             width: 36,
                          //             height: 45,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
