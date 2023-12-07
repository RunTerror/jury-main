// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/authentication/general/verification_page.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/provider1.dart';
import 'package:juridentt/resources/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool keepLoggedIn = true;
  late String userType1 = '';

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void initState() {
    userType1 = 'lawyer';
    super.initState();
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loseFocus() {
    _focusNode1.unfocus();
    _focusNode2.unfocus();
  }

  void loginClient() async {
    String res = await Auth().clientloginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    if (res == 'success') {
      
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const EmailVerification(usertype: 'client',);
          },
        ));

      // Navigator.pushNamed(context, '/clienthomescreen');
      // Navigator.pushNamed(context, '/clientsearchpage');
    }
    if (res == 'Incorrect password. Please try again.') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Incorrect password. Please try again.',
                textAlign: TextAlign.center,
                style: Constants.satoshiLightBlackNormal22),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: Constants.lightBlackBold,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
    if (res == 'User not found. Please create a new account.') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('User not found. Please create a new account.',
                textAlign: TextAlign.center,
                style: Constants.satoshiLightBlackNormal22),
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
    if (res == 'Some Error Occurred') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Some Error Occurred.',
                textAlign: TextAlign.center,
                style: Constants.satoshiLightBlackNormal22),
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

  late UserProvider _userProvider;

  void loginUser() async {
    _userProvider.toogleLoginLoading();
    String res = await Auth().lawyerloginUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (res == 'success') {
      _userProvider.toogleLoginLoading();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const EmailVerification(usertype: 'lawyer',);
          },
        ),
        (route) => false,
      );
    }
    if (res == 'Incorrect password. Please try again.') {
      _userProvider.toogleLoginLoading();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Incorrect password. Please try again.',
                textAlign: TextAlign.center,
                style: Constants.satoshiLightBlackNormal22),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: Constants.lightBlackBold,
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, '/lawyerlogin');
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    if (res == 'User not found. Please create a new account.') {
      _userProvider.toogleLoginLoading();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('User not found. Please create a new account.',
                textAlign: TextAlign.center,
                style: Constants.satoshiLightBlackNormal22),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: Constants.lightBlackBold),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return
                  // },));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    if (res == 'Some Error Occurred') {
      _userProvider.toogleLoginLoading();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Some Error Occurred.',
                textAlign: TextAlign.center,
                style: Constants.satoshiLightBlackNormal22),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: Constants.lightBlackBold),
                onPressed: () {
                  Navigator.of(context).pop();
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
    _userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                                Builder(
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 50.h,
                                      width: 160.w,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                    );
                                  },
                                ),
                                Transform(
                                  transform:
                                      Matrix4.translationValues(-20, 0, 0),
                                  child: Builder(
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 50.h,
                                        width: 165.w,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            backgroundColor:
                                                userType1 == 'lawyer'
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
                                      );
                                    },
                                  ),
                                ),
                              ],
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
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 160.h),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                context, '/signup');
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 28.w, bottom: 2.h),
                                            child: Text(
                                              "Sign Up",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: Constants
                                                  .satoshiLightBlackNormal22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -100.0, 0.0),
                                    child: TextFormField(
                                      style: Constants.satoshiBlackNormal18,
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
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -100.0, 0.0),
                                    child: TextFormField(
                                      focusNode: _focusNode2,
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
                                    padding: const EdgeInsets.only(right: 5),
                                    transform: Matrix4.translationValues(
                                        0.0, -60.0, 0.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 21.h,
                                          width: 21.w,
                                          decoration: BoxDecoration(
                                            color: Constants.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Checkbox(
                                            value: keepLoggedIn,
                                            onChanged: (value) {
                                              setState(() {
                                                keepLoggedIn = value!;
                                              });
                                            },
                                            activeColor: Constants.blue,
                                            checkColor: Constants.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.w, top: 2.h),
                                          child: Text(
                                            "Keep me Logged In",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: Constants.satoshiYellow14,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/forgetpassword');
                                          },
                                          child: Container(
                                            // height: 20.h,
                                            margin: EdgeInsets.only(
                                                left: 9.w, top: 2.h),
                                            child: Text(
                                              "Forgot Password?",
                                              textAlign: TextAlign.left,
                                              style: Constants.satoshiYellow14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (emailController.text.trim().isEmpty ||
                                            emailController.text
                                                .trim()
                                                .isEmpty ||
                                            passwordController.text
                                                .trim()
                                                .isEmpty ||
                                            passwordController.text
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
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            message:
                                                "Please fill the remaining fields",
                                            duration:
                                                const Duration(seconds: 3),
                                          ).show(context);
                                        } else {
                                          if (userType1 == 'lawyer') {
                                            loginUser();
                                            // Navigator.pushNamed(
                                            //   context,
                                            //   '/lawyerloginotp',
                                            //   arguments: {
                                            //     'useremail': emailController.text,
                                            //     'userpassword':
                                            //         passwordController.text,
                                            //   },
                                            // );
                                          } else {
                                            loginClient();
                                            // Navigator.pushNamed(
                                            //   context,
                                            //   '/clientloginotp',
                                            //   arguments: {
                                            //     'useremail': emailController.text,
                                            //     'userpassword':
                                            //         passwordController.text,
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
                                      child: Consumer(
                                        builder: (context, value, child) {
                                          if (_userProvider.isLoaginLoading) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Constants.orange,
                                              ),
                                            );
                                          }
                                          return Text(
                                            "Log in",
                                            style: Constants.satoshiWhite18,
                                          );
                                        },
                                      )),
                                ],
                              ),
                            ),
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
                            // Consumer<>(builder: (context, value, child) {

                            // },),
                            // ),
                            // const Flex(direction: Axis.vertical),
                            Padding(
                              padding: EdgeInsets.only(top: 13.h, bottom: 5.h),
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
                                    margin: const EdgeInsets.only(left: 50),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (userType1 == 'lawyer') {
                                          Auth()
                                              .signInWithGoogleLawyer(context);
                                        }
                                        if (userType1 == 'client') {
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
