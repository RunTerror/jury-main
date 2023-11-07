import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:provider/provider.dart';

import 'hamburgerIcon.dart';



class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  static const routeName = '/terms&conditions';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
       drawer: const HamburgerIcon(),
      appBar: AppBar(
        
         elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: themeProvider.darkModeButtonColor),
         title: Text("Terms and Conditions",style: TextStyle(
                                  fontSize: 20,
                                  color: themeProvider.lightHamText,
                                  fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.only(top: 2,bottom: 5),
            width: screenWidth,
            height: screenHeight * 0.15,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: screenWidth * 0.4,
                //   height: screenHeight * 0.4,
                //   child: Image.asset(
                //     'assets/Group 33622.png',
                //     fit: BoxFit.cover,
                //   ),
                // ),
                      Padding(
             padding: const EdgeInsets.only(top:8.0),
             child: 
          Image.asset("assets/Group 33622.png"),
             ),
                // const Expanded(
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 16.0),
                //     child: Text(
                //       'Terms and Conditions',
                //       style: TextStyle(
                //         fontSize: 30.0,
                //         color: Color(0xFFC99F4A),
                //       ),
                //     ),
                //   ),
                // ),
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
              decoration: BoxDecoration(gradient: themeProvider.scaffoldGradient,
                color: themeProvider.hamcontainer,),
              height: screenHeight * 0.76,
              //color: themeProvider.hamcontainer,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. Terms and Conditions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Color(0xFFC99F4A),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ipsum natustemporibus odio rerum. Eveniet, aperiam atque. Aperiam excepturi voluptates sint, asperiores ipsum nulla, suscipit recusandae fugit cum maxime laboriosam magnam ex at eos',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: themeProvider.casestext),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '2. Privacy Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Color(0xFFC99F4A),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt delectus rerum provident, ea iste quas explicabo est placeat qui quia, perspiciatis obcaecati! Esse perferendis officiis, velit dicta tempora laborum eos dignissimos magni minima earum excepturi voluptatem necessitatibus facere deleniti iust',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: themeProvider.casestext),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ipsum natustemporibus odio rerum. Eveniet,\n aperiam atque. \n Aperiam excepturi voluptates sint, asperiores ipsum nulla,',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: themeProvider.casestext),
                  ),
          
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}