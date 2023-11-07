import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/hamburgerMenu/hamburger_icon.dart';

import 'package:provider/provider.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  // static const routeName = '/Aboutus';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      drawer: const HamburgerIcon(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeProvider.editext,
        centerTitle: true,
        iconTheme: IconThemeData(color: themeProvider.skipButtonTextColor),
        title: Text(
          "About us",
          style: TextStyle(
              fontSize: 20,
              color: themeProvider.lightHamText,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: themeProvider.skipButtonTextColor,
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 3),
              width: screenWidth,
              height: screenHeight * 0.15,
              color: themeProvider.hamcontainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset("assets/Group 33622.png"),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10.0),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
              child: Container(
                decoration:
                    BoxDecoration(gradient: themeProvider.scaffoldGradient),
                height: screenHeight * 0.675,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VISION',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Color(0xFFC99F4A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ipsum natustemporibus odio rerum. Eveniet, aperiam atque. Aperiam excepturi voluptates sint, asperiores ipsum nulla, suscipit recusandae fugit cum maxime laboriosam magnam ex at eos',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: themeProvider.casestext),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'GOAL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Color(0xFFC99F4A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ipsum natustemporibus odio rerum. Eveniet, aperiam atque. Aperiam excepturi voluptates sint, asperiores ipsum nulla,',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: themeProvider.casestext),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ipsum natustemporibus odio rerum. Eveniet, aperiam atque. Aperiam excepturi voluptates sint, asperiores ipsum nulla,',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: themeProvider.casestext),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ipsum natustemporibus odio rerum. Eveniet, aperiam atque. Aperiam excepturi voluptates sint, asperiores ipsum nulla,',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: themeProvider.casestext),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ipsum natustemporibus odio rerum. Eveniet, aperiam atque. Aperiam excepturi voluptates sint, asperiores ipsum nulla,',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: themeProvider.casestext),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: const Navbar(),
            // ),
          ],
        ),
      ),
    );
  }
}
