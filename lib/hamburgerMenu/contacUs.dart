// import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/hamburgerMenu/editprofile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../addcase/provider.dart';
import '../constants.dart';
import 'faq.dart';

class ContactUs extends StatefulWidget {
  static const String routename = '/contactus';

  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // void launchEmail() async{
  //   List<String> to = ["jurident@gmail.com"];
  //   Email email = Email(to: to);
  //   EmailLauncher.launch(email).then((value){
  //     print(value);
  //   }).catchError((error){
  //     print(error);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      // bottomNavigationBar: Navbar(),
      appBar: AppBar(
        centerTitle: true,
        // elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: themeProvider.darkModeButtonColor),
        title: const Text(
          "Contact Us",
          style: TextStyle(color: Color(0xFFC99F4A)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFFC99F4A),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            width: screenWidth,
            height: screenHeight * 0.25,
            color: Constants.fromHex("#050125"),
            child: SizedBox(
              width: screenWidth * 0.4,
              height: screenHeight * 0.4,
              child: Image.asset(
                'assets/Group 33622.png',
                // fit: BoxFit.cover,
                // fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Container(
              color: themeProvider.hamcontainer,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05),
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30.0,
                        color: Color(0xFFC99F4A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05),
                    child: Text(
                      'Please Choose what types of support you need and let us know',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: themeProvider.notesbackground),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.08),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: screenHeight * 0.2,
                              width: screenWidth * 0.37,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey[200]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/chat.png"),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
                                    "Support Chat",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
                                    "24x7 Online Support",
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            InkWell(
                              onTap: () async {
                                await launchUrl(
                                    Uri.parse("tel:${'+917011881346'}"));
                              },
                              child: Container(
                                height: screenHeight * 0.2,
                                width: screenWidth * 0.37,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey[200]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/Call.png"),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                      "Call Center",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                      "24x7 Customer Support",
                                      style: TextStyle(
                                          fontSize: 9, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                await launchUrl(Uri.parse(
                                    "mailto:${'jurident@gmail.com'}"));
                              },
                              child: Container(
                                height: screenHeight * 0.2,
                                width: screenWidth * 0.37,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey[200]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/email.png"),
                                    // Icon(
                                    //   Icons.email_rounded,
                                    //   color: Colors.black,
                                    // ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                      "Email",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                      "jurident@gmail.com",
                                      style: TextStyle(
                                          fontSize: 9, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, FAQ.routename);
                              },
                              child: Container(
                                height: screenHeight * 0.2,
                                width: screenWidth * 0.37,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey[200]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/FAQ.png"),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                      "FAQ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                      const Text(
                                      "+50 Answers",
                                      style: TextStyle(
                                          fontSize: 9, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, EditProfile.routename);
                          },
                          child: Container(
                            height: screenHeight * 0.07,
                            width: screenWidth * 0.7,
                            decoration: BoxDecoration(
                                color: Constants.fromHex("#050125"),
                                borderRadius: BorderRadius.circular(16)),
                            child: const Center(
                                child: Text(
                              "Go To profile Page",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // SizedBox(height:screenHeight*0.065 ,)
                      ],
                    ),
                  ),

                  // Text("Hello",style: TextStyle(color: Colors.black),)
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Navbar(),
    );
  }
}