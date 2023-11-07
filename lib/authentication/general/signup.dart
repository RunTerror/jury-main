// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juridentt/authentication/client/login/login.dart';
import 'package:juridentt/authentication/client/signup/signup_otp.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/resources/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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

  void SignUpOtpClient() async {
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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account Created! ')));
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginScreenClient();
      },));
     
      // Navigator.pushNamed(context, '/clientlogin');
    }
    if (resp ==
        'The account already exists for that email. Please try creating a new account.') {
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
                  Navigator.pushNamed(context, '/clientlogin');
                },
              ),
            ],
          );
        },
      );
    }
    if (resp ==
        'The provided password is too weak. Please choose a stronger password.') {
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
                  Navigator.pushNamed(context, '/clientsignup');
                },
              ),
            ],
          );
        },
      );
    }
    if (resp == 'Some Error Occurred') {
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
                  Navigator.pushNamed(context, '/clientsignup');
                },
              ),
            ],
          );
        },
      );
    }
  }


  void signUpUser() async {
    String resp = await Auth().lawyerregisterUser(
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
      Navigator.pushNamed(context, '/lawyerlogin');
    }
    if (resp ==
        'The account already exists for that email. Please try creating a new account.') {
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
                  Navigator.pushNamed(context, '/lawyerlogin');
                },
              ),
            ],
          );
        },
      );
    }
    if (resp ==
        'The provided password is too weak. Please choose a stronger password.') {
      print(resp);
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
                  Navigator.pushNamed(context, '/lawyersignup');
                },
              ),
            ],
          );
        },
      );
    }
    if (resp == 'Some Error Occurred') {
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
                  Navigator.pushNamed(context, '/lawyersignup');
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
    final size = MediaQuery.of(context).size;
    // final height = size.height;
    // final width = size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_blue.png"),
                // image: AssetImage("assets/background.png"),
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
                            Row(
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  width: 160.w,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor: userType1 == 'client'
                                          ? const Color(0xff060125)
                                          : Colors.white,
                                      side: BorderSide(
                                        width: 2,
                                        color: userType1 == 'client'
                                            ? const Color(0xff060125)
                                            : Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        userType1 = 'client';
                                      });
                                      print(userType1);
                                    },
                                    child: Text(
                                      "Client",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: userType1 == 'client'
                                            ? const Color(0XFFc99f4a)
                                            : Colors.black,
                                        fontSize: 22.sp,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Transform(
                                  transform:
                                      Matrix4.translationValues(-20, 0, 0),
                                  child: SizedBox(
                                    height: 50.h,
                                    width: 160.w,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        backgroundColor: userType1 == 'lawyer'
                                            ? const Color(0xff060125)
                                            : Colors.white,
                                        side: BorderSide(
                                          width: 2,
                                          color: userType1 == 'lawyer'
                                              ? const Color(0xff060125)
                                              : Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          userType1 = 'lawyer';
                                        });
                                        print(userType1);
                                      },
                                      child: Text(
                                        "Lawyer",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: userType1 == 'lawyer'
                                              ? const Color(0XFFc99f4a)
                                              : Colors.black,
                                          fontSize: 22.sp,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/login');
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Log In",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: Constants
                                                      .satoshiLightBlackNormal22,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 28.h),
                                          child: Text(
                                            "Sign Up",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: Constants
                                                .satoshiTransparentNormal22Underline,
                                          ),
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
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                        }
                                        if (userType1 == 'lawyer') {

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

                                          SignUpOtpClient();


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
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants.lightblack,
                                        minimumSize: Size(320.w, 50.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        "Sign Up",
                                        style: Constants.satoshiWhite18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.h, bottom: 6.w),
                                  child: SizedBox(
                                    width: 149.w,
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Constants.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 7.w),
                                  child: const Text(
                                    "or",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
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
                                      color: Constants.black,
                                      indent: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.h, left: 135.w),
                              child: Text(
                                "Log In with",
                                style: Constants.satoshiGrey90016,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (userType1 == 'lawyer') {
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
                                        if (userType1 == 'lawyer') {
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
                                        if (userType1 == 'lawyer') {
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
