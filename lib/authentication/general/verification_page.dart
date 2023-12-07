import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/client/clientsearchpage.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/navbar.dart';
import 'package:provider/provider.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key, required this.usertype});
  final String usertype;

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  late bool isEmailVerified;
  Timer? timer;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerification();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
    super.initState();
  }

  sendVerification() async {
    final auth = FirebaseAuth.instance.currentUser!;
    await auth.sendEmailVerification();
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return isEmailVerified == false
        ? Scaffold(
            backgroundColor: themeProvider.hamcontainer,
            appBar: AppBar(
              backgroundColor: themeProvider.hamcontainer,
            ),
            body: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 162, 183, 201),
                      ),
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/verification_key.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email Verification',
                      style: TextStyle(
                          color: Constants.yellow,
                          fontWeight: FontWeight.w700,
                          fontSize: 30),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Please go to your registered email',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      'to verify your email account',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
          )
        : widget.usertype == 'lawyer'
            ? const PersistentNavbar()
            : const HomePage();
  }
}
