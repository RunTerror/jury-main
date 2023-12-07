import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/client/clientsearchpage.dart';
import 'package:juridentt/navbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpEmailVerification extends StatefulWidget {
  const SignUpEmailVerification(
      {super.key,
      required this.email,
      required this.password,
      required this.usertype});
  final String usertype;
  final String email;
  final String password;

  @override
  State<SignUpEmailVerification> createState() =>
      _SignUpEmailVerificationState();
}

class _SignUpEmailVerificationState extends State<SignUpEmailVerification> {
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
      login();
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  login() async {
    final sp = await SharedPreferences.getInstance();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: widget.email, password: widget.password)
        .then((value) async {
      await sp.setString('userType', widget.usertype);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return widget.usertype == 'lawyer'
                ? const PersistentNavbar()
                : const HomePage();
          },
        ), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.hamcontainer,
      appBar: AppBar(
        backgroundColor: themeProvider.hamcontainer,
      ),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Container(
                padding:const EdgeInsets.all(5),
                decoration:
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 162, 183, 201),),
                
                height: 100,
                width: 100,
                child: Image.asset('assets/verification_key.png'),
              ),
              const SizedBox(height: 10,),
              Text('Email Verification',style: TextStyle(color: themeProvider.dotbuttonColor, fontWeight: FontWeight.w700,fontSize: 30),),
               const SizedBox(height: 10,),
               const Text('Please go to your registered email',style: TextStyle(color: Colors.white),),
               const Text('to verify your email account',style: TextStyle(color: Colors.white),)
            ],
          )),
    );
  }
}


// TextButton(
//             onPressed: () async {
//               await FirebaseAuth.instance.currentUser!.sendEmailVerification();
//             },
//             child: const Text(
//               'Send Verification',
//             )),