import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/Bare%20acts/Bare_acts_page.dart';
import 'package:juridentt/Contact/chat_page.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/authentication/general/login.dart';
import 'package:juridentt/features/client_search/widgets.dart';
import 'package:juridentt/hamburgerMenu/faq.dart';
import 'package:juridentt/hamburgerMenu/feedback.dart';
import 'package:juridentt/internship_form.dart';
import 'package:juridentt/main.dart';
import 'package:juridentt/provider1.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HamburgerIcon extends StatefulWidget {
  static const String routename = '/hamburger';

  const HamburgerIcon({Key? key}) : super(key: key);

  @override
  State<HamburgerIcon> createState() => _HamburgerIconState();
}

class _HamburgerIconState extends State<HamburgerIcon> {
  bool isSwitched = false;
  bool isSwitched1 = false;
  late String lawyerName = '';
  User? currentUser;
  String uid = '';

  @override
  void initState() {
    super.initState();
    fetchLawyerId();
    // fetchCuurentId();
  }

  void initializeCurrentUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
    uid = currentUser!.uid;
    // print('uid:$uid');
  }

  Future<void> clearUser() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future<void> fetchLawyerId() async {
    final user = FirebaseAuth.instance.currentUser;
    final userDoc =
        FirebaseFirestore.instance.collection('lawyers').doc(user!.uid);
    final userData = await userDoc.get();
    setState(() {
      lawyerName = userData['name'];
    });
  }

  // Future<void> fetchCuurentId() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   final userDoc =
  //       FirebaseFirestore.instance.collection('clients').doc(user!.uid);
  //   final userData = await userDoc.get();
  //   setState(() {
  //     lawyerName = userData['name'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      backgroundColor: Theme.of(context).canvasColor,
      child: Container(
        decoration: BoxDecoration(gradient: themeProvider.scaffoldGradient),
        child: ListView(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.04),
              child: Row(children: [
                CachedNetworkImage(
                  imageUrl: userProvider.user.profile == ''
                      ? "https://picsum.photos/id/237/200/300"
                      : userProvider.user.profile,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lawyerName,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "Lawyer",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              ]),
            ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05, right: screenWidth * 0.03),
              child: const Row(
                children: [
                  Text("Language",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Expanded(
                    child: Text(""),
                  ),
                  Row(
                    children: [Text("En"), Icon(Icons.arrow_drop_up)],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, TermsAndConditions.routeName);
              },
              child: const CustomListTile(title: "Terms and Conditions"),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/Aboutus');
              },
              child: const CustomListTile(title: "About Us"),
            ),
            ListTile(
              title: const Text("Dark Mode",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              trailing: Switch.adaptive(
                activeColor: Colors.white,
                activeTrackColor: themeProvider.toggleColor,
                value: themeProvider.isDarkModeEnabled,
                onChanged: (value) {
                  final provider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme();
                },
              ),
            ),
            ListTile(
              title: const Text(
                "Notifications",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              trailing: Switch(
                activeColor: Colors.white,
                activeTrackColor: themeProvider.toggleColor,
                value: isSwitched1,
                onChanged: (value) {
                  setState(() {
                    isSwitched1 = value;
                  });
                },
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/contactus');
                },
                child: const CustomListTile(title: "Contact us")),
            InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, 'chat page');
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const ChatPage();
                    },
                  ));
                },
                child: const CustomListTile(title: "Support Chat")),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, FAQ.routename);
              },
              child: const CustomListTile(title: "FAQ"),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, FeedbackPage.routename);
              },
              child: const CustomListTile(title: "Feedback Page"),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const BareActsPage();
                }));
              },
              child: const CustomListTile(title: "BareActs Pdf"),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const InternShipForm();
                }));
              },
              child: const CustomListTile(title: "Internship Form"),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: () async {
                  clearUser();
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) {
                        return LawyerClientLogin();
                      },
                    ),
                    (route) {
                      return false;
                    },
                  );

                  // await FirebaseFirestore.instance
                  //     .collection('lawyers')
                  //     .doc('bpv6pevm3Ba8jmLK6UQaUK9xnaE3')
                  //     .get()
                  //     .then((value) => print(value.data()));
                },
                child: Container(
                  height: screenHeight * 0.055,
                  decoration: BoxDecoration(
                    color: themeProvider.hamcontainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "LogOut",
                      style: TextStyle(
                        color: themeProvider.opphamcontainer,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
