// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:juridentt/authentication/forget_password/forgetpassword.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/mkres.dart';
import 'package:juridentt/resources/auth.dart';
import 'package:sizer/sizer.dart';

class LoginScreenClient extends StatefulWidget {
  const LoginScreenClient({Key? key}) : super(key: key);

  @override
  State<LoginScreenClient> createState() => _LoginScreenClientState();
}

class _LoginScreenClientState extends State<LoginScreenClient> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool keepLoggedIn = true;

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(201, 159, 74, 0.54),
        backgroundColor: Constants.orange,
        // extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
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
                    padding: EdgeInsets.only(
                        left: make_responsive('w', 35, context),
                        right: make_responsive('w', 35, context),
                        top: make_responsive('h', 30, context)),
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
                          width: make_responsive('w', 359, context),
                          margin: EdgeInsets.only(
                              top: make_responsive('h', 17, context)),
                          child: Text(
                              "Are you ready to become a legal eagle? Login to the app and spread your wings in the courtroom.",
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              style: Constants.satoshiBlackNormal18),
                        ),
                        Container(
                          height: make_responsive('h', 464, context),
                          width: make_responsive('w', 440, context),
                          margin: EdgeInsets.only(
                              top: make_responsive('h', 30, context)),
                          padding: EdgeInsets.only(
                              left: make_responsive('w', 29, context),
                              right: make_responsive('w', 20, context),
                              bottom: make_responsive('h', 31, context)),
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
                                padding: EdgeInsets.only(
                                    bottom: make_responsive('w', 160, context)),
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
                                            context, '/clientsignup');
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: make_responsive(
                                                'w', 28, context),
                                            bottom: make_responsive(
                                                'w', 2, context)),
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
                                transform:
                                    Matrix4.translationValues(0.0, -100.0, 0.0),
                                child: TextFormField(
                                  focusNode: _focusNode1,
                                  onEditingComplete: _loseFocus,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    contentPadding: EdgeInsets.only(
                                      left: make_responsive('w', 10, context),
                                      top: make_responsive('h', 16, context),
                                      right: make_responsive('w', 7, context),
                                      bottom: make_responsive('h', 16, context),
                                    ),
                                    prefixIcon: Container(
                                      margin: EdgeInsets.only(
                                        left: make_responsive('w', 10, context),
                                        top: make_responsive('h', 16, context),
                                        right: make_responsive('w', 7, context),
                                        bottom:
                                            make_responsive('h', 16, context),
                                      ),
                                      child: Image.asset(
                                        'assets/images/mailsymbol.png',
                                        height:
                                            make_responsive('h', 20, context),
                                        width:
                                            make_responsive('w', 20, context),
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
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -100.0, 0.0),
                                child: TextFormField(
                                  focusNode: _focusNode2,
                                  onEditingComplete: _loseFocus,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    contentPadding: EdgeInsets.only(
                                      left: make_responsive('w', 10, context),
                                      top: make_responsive('h', 16, context),
                                      right: make_responsive('w', 7, context),
                                      bottom: make_responsive('h', 16, context),
                                    ),
                                    prefixIcon: Container(
                                      margin: EdgeInsets.only(
                                        left: make_responsive('w', 10, context),
                                        top: make_responsive('h', 16, context),
                                        right: make_responsive('w', 7, context),
                                        bottom:
                                            make_responsive('h', 16, context),
                                      ),
                                      child: Image.asset(
                                        'assets/images/passwordlock.png',
                                        height:
                                            make_responsive('h', 20, context),
                                        width:
                                            make_responsive('w', 20, context),
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
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
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
                                transform:
                                    Matrix4.translationValues(0.0, -60.0, 0.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: make_responsive('h', 21, context),
                                      width: make_responsive('w', 21, context),
                                      decoration: BoxDecoration(
                                        color: Constants.white,
                                        borderRadius: BorderRadius.circular(5),
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
                                          left:
                                              make_responsive('w', 2, context),
                                          top:
                                              make_responsive('h', 2, context)),
                                      child: Text(
                                        "Keep me Logged In",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: Constants.satoshiYellow14,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgetPassword(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height:
                                            make_responsive('h', 20, context),
                                        width:
                                            make_responsive('w', 115, context),
                                        margin: EdgeInsets.only(
                                            left: make_responsive(
                                                'w', 9, context),
                                            top: make_responsive(
                                                'h', 2, context)),
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: SizedBox(
                                                width: make_responsive(
                                                    'w', 115, context),
                                                child: Divider(
                                                  height: 2,
                                                  thickness: 2,
                                                  color: Constants.yellow,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "Forgot Password?",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                    Constants.satoshiYellow14,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                  }
                                  Navigator.pushNamed(
                                    context,
                                    '/clientloginotp',
                                    arguments: {
                                      'useremail': emailController.text,
                                      'userpassword': passwordController.text,
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.lightblack,
                                  minimumSize: Size(
                                      make_responsive('w', 320, context),
                                      make_responsive('h', 50, context)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  "Send OTP",
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
                              padding: EdgeInsets.only(
                                  top: make_responsive('h', 30, context),
                                  bottom: make_responsive('h', 6, context)),
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
                            style: Constants.satoshiGrey90016,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 13.h, bottom: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Auth().signInWithFacebookClient(context);
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
                                    Auth().signInWithGoogleClient(context);
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
                                    Auth().signInWithTwitterClients(context);
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
      ),
    );
  }
}
