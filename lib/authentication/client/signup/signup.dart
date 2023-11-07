import 'package:flutter/material.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/resources/auth.dart';
import 'package:sizer/sizer.dart';

class SignupScreenClient extends StatefulWidget {
  const SignupScreenClient({Key? key}) : super(key: key);

  @override
  State<SignupScreenClient> createState() => _SignupScreenClientState();
}

class _SignupScreenClientState extends State<SignupScreenClient> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

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
                            "Join a community of legal professionals and clients - together, we'll simplify the legal world.",
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            style: Constants.satoshiBlackNormal18,
                          ),
                        ),
                        Container(
                          height: 479.h,
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
                                padding: EdgeInsets.only(bottom: 110.h),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/clientlogin');
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
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: Constants
                                                  .satoshiLightBlackNormal22,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 28),
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
                                transform:
                                    Matrix4.translationValues(0.0, -80.0, 0.0),
                                child: TextFormField(
                                  focusNode: _focusNode1,
                                  onEditingComplete: _loseFocus,
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: "Username",
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
                                        'assets/images/personsymbol.png',
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
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -80.0, 0.0),
                                child: TextFormField(
                                  focusNode: _focusNode2,
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
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -60.0, 0.0),
                                child: TextFormField(
                                  focusNode: _focusNode3,
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
                                    Matrix4.translationValues(0.0, -40.0, 0.0),
                                child: TextFormField(
                                  focusNode: _focusNode4,
                                  onEditingComplete: _loseFocus,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Phone Number",
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
                                      // child: Image.asset(
                                      //   'assets/images/passwordlock.png',
                                      //   height: 20,
                                      //   width: 20,
                                      // ),
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
                                    Matrix4.translationValues(0.0, -20.0, 0.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                    }
                                    Navigator.pushNamed(
                                      context,
                                      '/clientsignupotp',
                                      arguments: {
                                        'email': emailController.text,
                                        'password': passwordController.text,
                                        'mobilenumber':
                                            phonenumberController.text,
                                        'username': usernameController.text,
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.lightblack,
                                    minimumSize: const Size(320, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    "Send OTP",
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
                          padding: const EdgeInsets.only(top: 3, left: 135),
                          child: Text(
                            "Log In with",
                            style: Constants.satoshiGrey90016,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Auth().signInWithFacebookClient(context);
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
                                    Auth().signInWithGoogleClient(context);
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
                                    Auth().signInWithTwitterClients(context);
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
