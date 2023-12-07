// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/authentication/client/login/login.dart';
import 'package:juridentt/authentication/general/signupverification.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/navbar.dart';
import 'package:juridentt/provider1.dart';
import 'package:juridentt/resources/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  final String usertype;
  const SignupScreen({Key? key, required this.usertype}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late UserProvider userProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  late String userType1 = '';

  @override
  void initState() {
    userType1 = 'lawyer';
    super.initState();
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    emailController.dispose();
    usernameController.dispose();
    phonenumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loseFocus() {
    _focusNode1.unfocus();
    _focusNode2.unfocus();
    _focusNode3.unfocus();
    _focusNode4.unfocus();
  }

  void signUpOtpClient() async {
    log('Client SignUp started');
    String resp = await Auth().clientregisterUser(
      profile: '',
      name: usernameController.text.trim(),
      location: '',
      lawyerId: '',
      clientId: '',
      mobileNumber: phonenumberController.text.trim(),
      email: emailController.text.trim(),
      address: '',
      type: '',
      password: passwordController.text.trim(),
    );
    print(resp);
    if (resp == 'success') {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Account Created! ')));
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const LoginScreenClient();
            },
          ));
        }
      } else {
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SignUpEmailVerification(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
                usertype: 'client',
              );
            },
          ));
        }
      }
    }
    if (resp ==
        'The account already exists for that email. Please try creating a new account.') {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Email already exists. Please create a new account.',
              textAlign: TextAlign.center,
              style: Constants.satoshiLightBlackNormal22,
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: Constants.lightBlackBold),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
    if (resp ==
        'The provided password is too weak. Please choose a stronger password.') {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'The provided password is too weak. Please choose a stronger password.',
              textAlign: TextAlign.center,
              style: Constants.satoshiLightBlackNormal22,
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: Constants.lightBlackBold),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
    if (resp == 'Some Error Occurred') {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Some Error Occurred. Please try again.',
              textAlign: TextAlign.center,
              style: Constants.satoshiLightBlackNormal22,
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: Constants.lightBlackBold),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  // void sendOtp()async{
  //  EmailAuth emailAuth =   EmailAuth(sessionName: "Sample session");
  //  await emailAuth.sendOtp(recipientMail: 'bansalabhishek7411@gmail.com').then((value) => print(value));

  // }

  void signUpUser() async {
    log('laweyer signup started');
    userProvider.toogleLoading();
    String resp = await Auth().lawyerregisterUser(
      isVerified: false,
      profile: '',
      name: usernameController.text.trim(),
      location: '',
      lawyerId: '',
      clientId: '',
      mobileNumber: phonenumberController.text.trim(),
      email: emailController.text.trim(),
      address: '',
      type: '',
      password: passwordController.text.trim(),
    );

    if (resp == 'success') {
      // ignore: use_build_context_synchronously
      userProvider.toogleLoading();
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const PersistentNavbar();
              },
            ),
            (route) => false,
          );
        }
      } else {
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SignUpEmailVerification(
                usertype: 'lawyer',
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
            },
          ));
        }
      }
    }
    if (resp ==
        'The account already exists for that email. Please try creating a new account.') {
      userProvider.toogleLoading();
      // ignore: use_build_context_synchronously

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Email already exists. Please create a new account.',
                textAlign: TextAlign.center,
                style: Constants.satoshiLightBlackNormal22,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK', style: Constants.lightBlackBold),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    }
    if (resp ==
        'The provided password is too weak. Please choose a stronger password.') {
      print(resp);
      // ignore: use_build_context_synchronously
      userProvider.toogleLoading();
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'The provided password is too weak. Please choose a stronger password.',
                textAlign: TextAlign.center,
                style: Constants.satoshiLightBlackNormal22,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK', style: Constants.lightBlackBold),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    }
    if (resp == 'Some Error Occurred') {
      // ignore: use_build_context_synchronously
      userProvider.toogleLoading();
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Some Error Occurred. Please try again.',
                textAlign: TextAlign.center,
                style: Constants.satoshiLightBlackNormal22,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK', style: Constants.lightBlackBold),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;
    // final height = size.height;
    // final width = size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.hamcontainer,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/ellipse.png',
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(0, 50, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 0.h),
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
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              height: 479.h,
                              width: 440.w,
                              margin: EdgeInsets.only(top: 30.h),
                              padding: EdgeInsets.only(left: 29.w, right: 20.w),
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
                                    padding: EdgeInsets.only(bottom: 110.h),
                                    child: Row(
                                      children: [
                                        widget.usertype == 'lawyer'
                                            ? Text(
                                                "Join as Lawyer",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: Constants
                                                    .satoshiYellowNormal22,
                                              )
                                            : Text(
                                                "Join as Client",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: Constants
                                                    .satoshiYellowNormal22,
                                              ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -80.0, 0.0),
                                    child: TextFormField(
                                      focusNode: _focusNode1,
                                      onEditingComplete: _loseFocus,
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                        hintText: "Username",
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
                                            'assets/images/personsymbol.png',
                                            height: 20.h,
                                            width: 20.w,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: Constants.black,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: Constants.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -80.0, 0.0),
                                    child: TextFormField(
                                      focusNode: _focusNode2,
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
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: Constants.black,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
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
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -60.0, 0.0),
                                    child: TextFormField(
                                      focusNode: _focusNode3,
                                      onEditingComplete: _loseFocus,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        hintText: "Password",
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
                                            'assets/images/passwordlock.png',
                                            height: 20.h,
                                            width: 20.w,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: Constants.black,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: Constants.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -40.0, 0.0),
                                    child: TextFormField(
                                      focusNode: _focusNode4,
                                      onEditingComplete: _loseFocus,
                                      controller: phonenumberController,
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
                                          // child: Image.asset(
                                          //   'assets/images/phone.png',
                                          //   height: 20,
                                          //   width: 20,
                                          // ),
                                          child: Icon(
                                            Icons.phone,
                                            color: Constants.black,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: Constants.black,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: Constants.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -20.0, 0.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          // if (_formKey.currentState!.validate()) {
                                          //   _formKey.currentState!.save();
                                          // }
                                          if (usernameController.text.trim().isEmpty ||
                                              emailController.text
                                                  .trim()
                                                  .isEmpty ||
                                              passwordController.text
                                                  .trim()
                                                  .isEmpty ||
                                              phonenumberController.text
                                                  .trim()
                                                  .isEmpty) {
                                            Flushbar(
                                              backgroundColor:
                                                  const Color(0xFF40A2B6),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              isDismissible: true,
                                              flushbarPosition:
                                                  FlushbarPosition.BOTTOM,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              message:
                                                  "Please fill the remaining fields",
                                              duration:
                                                  const Duration(seconds: 3),
                                            ).show(context);
                                          } else {
                                            if (widget.usertype == 'lawyer') {
                                              print('lawyer signup started');
                                              // userProvider.toogleLoading();
                                              signUpUser();

                                              // Navigator.pushNamed(
                                              //   context,
                                              //   '/lawyersignupotp',
                                              //   arguments: {
                                              //     'email': emailController.text,
                                              //     'password':
                                              //         passwordController.text,
                                              //     'mobilenumber':
                                              //         phonenumberController.text,
                                              //     'username':
                                              //         usernameController.text,
                                              //   },
                                              // );
                                            } else {
                                              signUpOtpClient();

                                              // Navigator.pushNamed(
                                              //   context,
                                              //   '/clientsignupotp',
                                              //   arguments: {
                                              //     'email': emailController.text,
                                              //     'password':
                                              //         passwordController.text,
                                              //     'mobilenumber':
                                              //         phonenumberController.text,
                                              //     'username':
                                              //         usernameController.text,
                                              //   },
                                              // );
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Constants.lightblack,
                                          minimumSize: Size(320.w, 50.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Consumer<UserProvider>(
                                          builder: (context, value, child) {
                                            print(value.isSignupLoading);
                                            if (value.isSignupLoading == true) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Constants.yellow,
                                                ),
                                              );
                                            }
                                            return Text(
                                              "Sign Up",
                                              style: Constants.satoshiWhite18,
                                            );
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.h, bottom: 6.h),
                                  child: SizedBox(
                                    width: 149.w,
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Constants.yellow,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 7.w),
                                  child: const Text(
                                    "or",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.yellow),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 14.h, bottom: 6.h),
                                  child: SizedBox(
                                    width: 149.w,
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Constants.yellow,
                                      indent: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "Log In with",
                                style: Constants.satoshiYellow14,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (widget.usertype == 'lawyer') {
                                        Auth()
                                            .signInWithFacebookLawyer(context);
                                      } else {
                                        Auth()
                                            .signInWithFacebookClient(context);
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/images/facebook_logo.png',
                                      width: 45.w,
                                      height: 45.h,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 50.w),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (widget.usertype == 'lawyer') {
                                          print('clicked');
                                          Auth()
                                              .signInWithGoogleLawyer(context);
                                        } else {
                                          Auth()
                                              .signInWithGoogleClient(context);
                                        }
                                      },
                                      child: Image.asset(
                                        'assets/images/google_logo.png',
                                        width: 48.w,
                                        height: 48.h,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 50.w, top: 4.h, bottom: 4.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (widget.usertype == 'lawyer') {
                                          Auth()
                                              .signInWithTwitterLawyer(context);
                                        } else {
                                          Auth().signInWithTwitterClients(
                                              context);
                                        }
                                      },
                                      child: Image.asset(
                                        'assets/images/twitter_logo.png',
                                        width: 36.w,
                                        height: 45.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
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
