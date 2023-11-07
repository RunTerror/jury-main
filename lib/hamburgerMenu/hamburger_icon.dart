import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/features/client_search/widgets.dart';
//import 'package:juridentt/hamburgerMenu/aboutUs.dart';
import 'package:juridentt/hamburgerMenu/faq.dart';
import 'package:juridentt/hamburgerMenu/feedback.dart';
import 'package:juridentt/hamburgerMenu/terms.dart';
// import 'package:jurident/colors.dart';
// import 'package:jurident/theme_changer_provider.dart';
// import 'package:jurident/theme_changer_provider.dart';

import 'package:provider/provider.dart';


// import '../constants.dart';
// import '../provider.dart';
// import 'theme_changer_provider.dart';

class HamburgerIcon extends StatefulWidget {
  static const String routename = '/hamburger';
  const HamburgerIcon({super.key});

  @override
  State<HamburgerIcon> createState() => _HamburgerIconState();
}

class _HamburgerIconState extends State<HamburgerIcon> {
  bool isSwitched = false;
  bool isSwitched1 = false;
  // bool isDarkModeEnabled=false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      backgroundColor: Theme.of(context).canvasColor,
      child: Container(
        decoration: BoxDecoration(gradient: themeProvider.scaffoldGradient),
        child: ListView(
          children: [
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.04),
              child: Row(children: [
                CircleAvatar(
                  radius: screenHeight * 0.055,
                  backgroundImage: const NetworkImage(
                      "https://picsum.photos/id/237/200/300"),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                const Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sinjin John",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    Text(
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
                  Navigator.pushNamed(context, TermsAndConditions.routeName);
                },
                child: const CustomListTile(title: "Terms and Conditions")),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/Aboutus');
                },
                child: const CustomListTile(title: "About Us")),
            ListTile(
                title: const Text("Dark Mode",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                trailing: Switch.adaptive(
                    // thumbIcon: Icons.check,
                    activeColor: Colors.white,
                    activeTrackColor: themeProvider.toggleColor,
                    value: themeProvider.isDarkModeEnabled,
                    onChanged: (value) {
                      final provider =
                          Provider.of<ThemeProvider>(context, listen: false);
                      provider.toggleTheme();
                    })),
            ListTile(
                title: const Text(
                  "Notifications",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: Switch(
                    // thumbIcon: Icons.check,
                    activeColor: Colors.white,
                    activeTrackColor: themeProvider.toggleColor,
                    value: isSwitched1,
                    onChanged: (value) {
                      setState(() {
                        isSwitched1 = value;
                      });
                    })),
           // const CustomListTile(title: "Contact Us"),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/contactus');
                },
                child: const CustomListTile(title: "Contact us")),
            const CustomListTile(title: "Support Chat"),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, FAQ.routename);
                },
                child: const CustomListTile(title: "FAQ")),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, FeedbackPage.routename);
                },
                child: const CustomListTile(title: "Feedback Page")),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: screenHeight * 0.055,
                // width: screenWidth*0.01,
                decoration: BoxDecoration(
                    color: themeProvider.hamcontainer,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(
                  "LogOut",
                  style: TextStyle(
                      color: themeProvider.opphamcontainer,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}