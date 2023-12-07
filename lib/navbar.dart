import 'package:flutter/material.dart';
import 'package:juridentt/addcase/cases.dart';
import 'package:juridentt/addcase/newcase_form.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/calender/calendar.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/hamburgerMenu/editprofile.dart';
import 'package:juridentt/hamburgerMenu/hamburgerIcon.dart';
import 'package:juridentt/news/news.dart';
import 'package:provider/provider.dart';

class PersistentNavbar extends StatefulWidget {
  const PersistentNavbar({
    super.key,
  });

  @override
  State<PersistentNavbar> createState() => _PersistentNavbarState();
}

class _PersistentNavbarState extends State<PersistentNavbar> {
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: BottomNavigationBar(
          iconSize: 30,
          selectedLabelStyle: TextStyle(color: Constants.yellow),
          unselectedLabelStyle: TextStyle(color: themeProvider.hamcontainer),
          backgroundColor: Colors.white,
          currentIndex: _cIndex,
          selectedItemColor: Constants.yellow,
          unselectedItemColor: themeProvider.hamcontainer,
          type: BottomNavigationBarType.fixed,
          items: _navBarsItems(themeProvider, _cIndex),
          onTap: (index) {
            if (index != 2) {
              _incrementTab(index);
            }
          },
        ),
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

  final List<Widget> _buildScreens = [
    const CasePage(),
    const NewsPage(),
    Container(),
    const Calendar(),
    const EditProfile(),
  ];
}

List<BottomNavigationBarItem> _navBarsItems(
    ThemeProvider themeProvider, int index) {
  return [
    BottomNavigationBarItem(
      icon: Icon(
        index == 0 ? Icons.home_filled : Icons.home_outlined,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          index == 1 ? Icons.newspaper : Icons.newspaper_outlined,
        ),
        label: 'News'),
    const BottomNavigationBarItem(
        icon: Icon(
          null,
        ),
        label: ''),
    BottomNavigationBarItem(
      icon: Icon(
        index == 4 ? Icons.calendar_month_sharp : Icons.calendar_month_outlined,
      ),
      label: 'Calendar',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        size: 30,
        index == 5 ? Icons.person : Icons.person_2_outlined,
      ),
      label: 'Account',
    ),
  ];
}
// }
