// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:juridentt/authentication/forget_password/forgetpassword.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/resources/auth.dart';

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

  void loginUser() async {
    String res = await Auth().lawyerloginUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (res == 'success') {
      Navigator.pushNamed(context, '/lawyerhomescreen');
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
                  Navigator.pushNamed(context, '/lawyerlogin');
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
                  Navigator.pushNamed(context, '/lawyerlogin');
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
                  Navigator.pushNamed(context, '/lawyerlogin');
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
                    padding:
                        const EdgeInsets.only(left: 35, right: 35, top: 30),
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
                          width: 358,
                          margin: const EdgeInsets.only(top: 17),
                          child: Text(
                              "Are you ready to become a legal eagle? Login to the app and spread your wings in the courtroom.",
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              style: Constants.satoshiBlackNormal18),
                        ),
                        Container(
                          height: 464,
                          width: 440,
                          margin: const EdgeInsets.only(top: 30),
                          padding: const EdgeInsets.only(
                              left: 29, right: 20, bottom: 31),
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
                                padding: const EdgeInsets.only(bottom: 160),
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
                                            context, '/lawyersignup');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28, bottom: 2),
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
                                  style: Constants.satoshiBlackNormal18,
                                  focusNode: _focusNode1,
                                  onEditingComplete: _loseFocus,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    contentPadding: const EdgeInsets.only(
                                      left: 10,
                                      top: 16,
                                      right: 7,
                                      bottom: 16,
                                    ),
                                    prefixIcon: Container(
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                        top: 16,
                                        right: 7,
                                        bottom: 16,
                                      ),
                                      child: Image.asset(
                                        'assets/images/mailsymbol.png',
                                        height: 20,
                                        width: 20,
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
                              const SizedBox(
                                height: 20,
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
                                    contentPadding: const EdgeInsets.only(
                                      left: 10,
                                      top: 16,
                                      right: 7,
                                      bottom: 16,
                                    ),
                                    prefixIcon: Container(
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                        top: 16,
                                        right: 7,
                                        bottom: 16,
                                      ),
                                      child: Image.asset(
                                        'assets/images/passwordlock.png',
                                        height: 20,
                                        width: 20,
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
                                      height: 21,
                                      width: 21,
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
                                      padding: const EdgeInsets.only(
                                          left: 2, top: 2),
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
                                        height: 20,
                                        width: 115,
                                        margin: const EdgeInsets.only(
                                            left: 9, top: 2),
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: SizedBox(
                                                width: 115,
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

                                  loginUser();
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   '/lawyerloginotp',
                                  //   arguments: {
                                  //     'useremail': emailController.text,
                                  //     'userpassword': passwordController.text,
                                  //   },
                                  // );
                                  // if (_formKey.currentState!.validate()) {
                                  //   _formKey.currentState!.save();
                                  // }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.lightblack,
                                  minimumSize: const Size(320, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  "Log in",
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 6),
                              child: SizedBox(
                                width: 149,
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Constants.black,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 7),
                              child: Text(
                                "or",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14, bottom: 6),
                              child: SizedBox(
                                width: 149,
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
                          padding: const EdgeInsets.only(top: 5, left: 130),
                          child: Text(
                            "Log In with",
                            style: Constants.satoshiGrey90016,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 13, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Auth().signInWithFacebookLawyer(context);
                                },
                                child: Image.asset(
                                  'assets/images/facebook_logo.png',
                                  width: 45,
                                  height: 45,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: GestureDetector(
                                  onTap: () {
                                    Auth().signInWithGoogleLawyer(context);
                                  },
                                  child: Image.asset(
                                    'assets/images/google_logo.png',
                                    width: 48,
                                    height: 48,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 50, top: 4, bottom: 4),
                                child: GestureDetector(
                                  onTap: () {
                                    Auth().signInWithTwitterLawyer(context);
                                  },
                                  child: Image.asset(
                                    'assets/images/twitter_logo.png',
                                    width: 36,
                                    height: 45,
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
