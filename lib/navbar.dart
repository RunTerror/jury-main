import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/addcase/cases.dart';
import 'package:juridentt/addcase/newcase_form.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/calender/calendar.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/hamburgerMenu/editprofile.dart';
import 'package:juridentt/hamburgerMenu/hamburger_icon.dart';
import 'package:juridentt/news/news.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class PersistentNavbar extends StatefulWidget {
  PersistentNavbar({
    super.key,
  });

  @override
  State<PersistentNavbar> createState() => _PersistentNavbarState();
}

class _PersistentNavbarState extends State<PersistentNavbar> {
  // final controller = PersistentTabController(initialIndex: 0);

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  void hidenavbar() {}

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      drawer: const HamburgerIcon(),
      body: _buildScreens[_cIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedLabelStyle: TextStyle(color: Constants.yellow),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        backgroundColor: themeProvider.hamcontainer,
        currentIndex: _cIndex,
        selectedItemColor: Constants.yellow,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: _navBarsItems(themeProvider),
        onTap: (index) {
          if(index!=2){
            _incrementTab(index);
          }
          
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.yellow,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return newcase_form();
            },
          ));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  // PersistentTabView(
  //     context,
  //     controller: controller,
  //     // floatingActionButton: const SizedBox(),
  //     screens: _buildScreens(),
  //     items: _navBarsItems(themeProvider),
  //     backgroundColor: themeProvider.hamcontainer,
  //     navBarStyle: NavBarStyle.style15, // Adjust the style as needed
  //     confineInSafeArea: false,
  //     handleAndroidBackButtonPress: true,
  //     hideNavigationBarWhenKeyboardShows: true,
  //     resizeToAvoidBottomInset: false,
  //     hideNavigationBar: false,
  //     stateManagement: true,
  //     screenTransitionAnimation: const ScreenTransitionAnimation(
  //       animateTabTransition: true,
  //       curve: Curves.bounceIn,
  //     ),
  //     decoration: NavBarDecoration(
  //       borderRadius: BorderRadius.only(
  //           topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
  //     ),
  //   ))

  final List<Widget> _buildScreens = [
    CasePage(),
    NewsPage(),
    Container(),
    Calendar(),
    EditProfile(),
   
  ];
}

List<BottomNavigationBarItem> _navBarsItems(ThemeProvider themeProvider) {
  return const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.newspaper_outlined,
        ),
        label: 'News'),
        BottomNavigationBarItem(
        icon: Icon(
          null,
        ),
        label: ''),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.calendar_month_outlined,
      ),
      label: 'Calendar',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        size: 30,
        Icons.person_2_outlined,
      ),
      label: 'Account',
    ),
  ];
}
// }
