import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/addcase/cases.dart';
import 'package:juridentt/addcase/newcase_form.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/calender/calendar.dart';
import 'package:juridentt/hamburgerMenu/editprofile.dart';
import 'package:juridentt/news/news.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PersistentNavbar extends StatelessWidget {
  PersistentNavbar({
    super.key,
  });
  final controller = PersistentTabController(initialIndex: 0);
  final themeProvider = ThemeProvider();

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      floatingActionButton: const SizedBox(),
      screens: _buildScreens(),
      items: _navBarsItems(themeProvider),
      backgroundColor: themeProvider.hamcontainer,
      navBarStyle: NavBarStyle.style15, // Adjust the style as needed
      confineInSafeArea: false,
      handleAndroidBackButtonPress: true,
      hideNavigationBarWhenKeyboardShows: false,
      resizeToAvoidBottomInset: false,
      hideNavigationBar: false,

      stateManagement: true,

      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.bounceIn,
      ),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const CasePage(),
      const NewsPage(),
      newcase_form(),
      const Calendar(),
      const EditProfile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(ThemeProvider themeProvider) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home_outlined,
        ),
        title: 'Home',
        activeColorPrimary: const Color(0xFFC99F4A),
        inactiveColorPrimary: themeProvider.notesbackground,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.newspaper_outlined,
        ),
        title: 'News',
        activeColorPrimary: const Color(0xFFC99F4A),
        inactiveColorPrimary: themeProvider.notesbackground,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        title: ' ',
        activeColorPrimary: const Color(0xFFC99F4A),
        inactiveColorPrimary: themeProvider.notesbackground,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.calendar_month_outlined,
        ),
        title: 'Calendar',
        activeColorPrimary: const Color(0xFFC99F4A),
        inactiveColorPrimary: themeProvider.notesbackground,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person_2_outlined,
        ),
        title: 'Account',
        activeColorPrimary: const Color(0xFFC99F4A),
        inactiveColorPrimary: themeProvider.notesbackground,
      ),
    ];
  }
}
