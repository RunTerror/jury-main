// ignore_for_file: use_build_context_synchronously

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/otp_all.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/resources/auth.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:email_otp/email_otp.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpOtp extends StatefulWidget {
  const SignUpOtp({
    Key? key,
    required this.username,
    required this.email,
    required this.password,
    required this.mobileNumber,
  }) : super(key: key);

  final String username;
  final String email;
  final String password;
  final String mobileNumber;

  @override
  State<SignUpOtp> createState() => _SignUpOtpState();
}

class _SignUpOtpState extends State<SignUpOtp> {
  late EmailOTP _emailOtp;
  late String _otp;
  int _remainingTime = 93; // 1.33 minutes in seconds
  Timer? _resendTimer;
   EmailAuth emailAuth=EmailAuth(sessionName: 'test');

  @override
  void initState() {
    super.initState();

    signUpUser();
    _emailOtp = EmailOTP();

    startResendTimer();
    _setConfig();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  sendingOtp() async {
    print('enterd');

    try {
       bool result = await emailAuth
        .sendOtp(recipientMail: widget.email, otpLength: 6);
         if (result) {
      print('done');
    } else {
      print('rejected');
    }
      
    } catch (e) {
      print(e);
      
    }

   
   
  }

  void signUpUser() async {
    String resp = await Auth().lawyerregisterUser(
      profile: '',
      name: widget.username,
      location: '',
      lawyerId: '',
      clientId: '',
      mobileNumber: widget.mobileNumber,
      email: widget.email,
      address: '',
      type: '',
      password: widget.password,
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

  void startResendTimer() {
    const oneSec = Duration(seconds: 1);
    _resendTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_remainingTime == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _remainingTime--;
          });
        }
      },
    );
  }

  String formatTimer(int seconds) {
    final minutes = (seconds / 60).floor().toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  void _setConfig() async {
    print('config started');
    await _emailOtp.setConfig(
      appEmail: 'juridentyi@gmail.com',
      appName: 'Jurident',
      userEmail: widget.email,
      otpLength: 5,
    );
    print('config done');
    _sendOtp();
  }

  void _sendOtp() async {
    print('reached');
    try {
      bool success = await _emailOtp.sendOTP();
      if (success) {
        print('success');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP Sent'),
          ),
        );
      } else {
        print('problem');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error Sending OTP'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void _verifyOtp() async {
    bool success = await _emailOtp.verifyOTP(otp: _otp);
    if (success) {
      
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Invalid OTP',
              textAlign: TextAlign.center,
              style: Constants.satoshiLightBlackNormal22,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(201, 159, 74, 0.54),
        backgroundColor: Constants.orange,
        // extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
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
                          "Join a community of legal professionals and clients - together, we'll simplify the legal world.",
                          maxLines: null,
                          textAlign: TextAlign.justify,
                          style: Constants.satoshiBlackNormal18,
                        ),
                      ),
                      Container(
                        height: 464.h,
                        width: 440.w,
                        margin: EdgeInsets.only(top: 30.h),
                        padding: EdgeInsets.only(
                            left: 29.w, right: 20.w, bottom: 10.h),
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
                              padding: EdgeInsets.only(bottom: 190.h),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/lawyerlogin');
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Log In",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: Constants
                                                .satoshiLightBlackNormal22,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 28.w, bottom: 2.h),
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
                              transform: Matrix4.translationValues(65, -140, 0),
                              child: Text(
                                'OTP Verification',
                                textAlign: TextAlign.center,
                                style: Constants.satoshiLightBlackNormal22,
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(60, -120, 0),
                              child: Text(
                                'Enter the OTP sent to',
                                textAlign: TextAlign.center,
                                style: Constants.satoshiLightBlackNormal18,
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(25, -114, 0),
                              child: Text(
                                widget.email,
                                textAlign: TextAlign.center,
                                style: Constants.satoshiLightBlackNormal18,
                              ),
                            ),
                            Container(
                              height: 49.h,
                              transform: Matrix4.translationValues(0, -100, 0),
                              child: OtpTextField(
                                numberOfFields: 5,
                                showFieldAsBox: true,
                                fieldWidth: 45.w,
                                borderRadius: BorderRadius.circular(7),
                                borderWidth: 1,
                                fillColor: Constants.white,
                                cursorColor: Constants.black,
                                enabledBorderColor: Constants.black,
                                onSubmit: (String verificationCode) {
                                  _otp = verificationCode;
                                },
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -60.0, 0.0),
                              child: Container(
                                margin: EdgeInsets.only(left: 110.w),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap:
                                          _remainingTime == 0 ? _sendOtp : null,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "Resend OTP",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: Constants
                                              .satoshiYellowUnderline14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 6.w, bottom: 5.h),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "in ${formatTimer(_remainingTime)}",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: Constants
                                              .satoshiLightBlackNormal14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _verifyOtp();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.lightblack,
                                minimumSize: Size(320.w, 50.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Sign Up",
                                style: Constants.satoshiWhite18,
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
                            padding: EdgeInsets.only(top: 20.h, bottom: 6.h),
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
                            padding: EdgeInsets.only(top: 14.h, bottom: 6.h),
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
                        padding: EdgeInsets.only(top: 5.h, left: 135.w),
                        child: Text(
                          "Log In with",
                          style: Constants.satoshiBlackNormal18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 13.h, bottom: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Handle Google button tap
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
                                  // Auth().signWithGoogle(context);
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
                                  // Auth().signInWithTwitter(context);
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
            ],
          ),
        ),
      ),
    );
  }
}
