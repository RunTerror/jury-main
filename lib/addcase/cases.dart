import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:provider/provider.dart';
import '../calender/calendar.dart';
import '../faqpage.dart';
import '../features/teams/sharedcases.dart';
import '../files/myfile.dart';
import '../hamburgerMenu/hamburgerIcon.dart';
import '../taskpage.dart';
import 'caseswidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'newcase_form.dart';

class CasePage extends StatefulWidget {
  const CasePage({Key? key}) : super(key: key);

  @override
  State<CasePage> createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  late String lawyerId;
  late String lawyerName;
  List<Map<String, dynamic>> openCases = [];
  List<Map<String, dynamic>> openCasesLists = [];
  List<Map<String, dynamic>> closedCases = [];
  List<Map<String, dynamic>> closedCasesLists = [];
  List<Map<String, dynamic>> upcomingCases = [];
  List<Map<String, dynamic>> upcomingCasesLists = [];
  bool isListViewVisible = false;
  int selectedCaseIndex = -1;

  User? currentUser;
  String uid = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> fetchData() async {
    await fetchLawyerId();
    initializeCurrentUser();

    final futures = <Future<void>>[
      Future.delayed(Duration.zero, () => openCasesList()),
      Future.delayed(Duration.zero, () => closedCasesList()),
      Future.delayed(Duration.zero, () => upcomingCasesList()),
    ];

    await Future.wait(futures);
  }

  void initializeCurrentUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
    uid = currentUser!.uid;
    //print('uid:$uid');
  }

  Future<void> fetchLawyerId() async {
    final user = FirebaseAuth.instance.currentUser;
    final userDoc =
        FirebaseFirestore.instance.collection('lawyers').doc(user!.uid);
    final userData = await userDoc.get();
    setState(() {
      lawyerId = userData['lawyerId'];
      print(lawyerId);

      lawyerName = userData['name'];
      print(lawyerName);
    });
  }

  void openCasesList() async {
    final trace = FirebasePerformance.instance.newTrace('openCasesListTrace');
    await trace.start();
    // print(uid);
    FirebaseFirestore.instance
        .collection('open')
        //.where('team', arrayContains: uid)
        .where('owner', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) {
      List<Map<String, dynamic>> openCases =
          snapshot.docs.map((doc) => doc.data()).toList();
      setState(() {
        openCasesLists = openCases;
      });
    });
    await trace.stop();
  }

  void closedCasesList() async {
    final trace = FirebasePerformance.instance.newTrace('closedlisttrace');
    await trace.start();
    // print("Inside closedCasesList"); // Add this line to indicate the method is being called
    FirebaseFirestore.instance
        .collection('closed')
        .where('owner', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) {
      // print("Closed Cases Snapshot: $snapshot"); // Add this line to check the snapshot value
      List<Map<String, dynamic>> closedCases =
          snapshot.docs.map((doc) => doc.data()).toList();
      // print("Closed Cases: $closedCases"); // Add this line to check the closed cases data
      setState(() {
        closedCasesLists = closedCases;
      });
    });
    await trace.stop();
  }

  void upcomingCasesList() async {
    final trace = FirebasePerformance.instance.newTrace('upcominglisttrace');
    await trace.start();
    FirebaseFirestore.instance
        .collection('upcoming')
        // .where('team', arrayContains: lawyerId)
        .where('owner', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) {
      List<Map<String, dynamic>> upcomingCases =
          snapshot.docs.map((doc) => doc.data()).toList();
      setState(() {
        upcomingCasesLists = upcomingCases;
      });
    });
    await trace.stop();
  }

  void handleCaseTap(int index) {
    setState(() {
      if (selectedCaseIndex == index) {
        selectedCaseIndex = -1;
        isListViewVisible = false;
      } else {
        selectedCaseIndex = index;
        isListViewVisible = true;
      }
    });
  }

  void handleCaseTapCancel() {
    setState(() {
      selectedCaseIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: themeProvider.ham),
        centerTitle: true,
        backgroundColor: themeProvider.appbarcolor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Container(
                  // width: 35,
                  decoration: BoxDecoration(
                    // color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: themeProvider.ham,
                  )),
            ),
          ),
        ],
      ),
      drawer: const HamburgerIcon(),

      // backgroundColor: themeProvider.,
      body: Container(
        decoration:
            BoxDecoration(gradient: themeProvider.scaffoldGradientscrol),
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "JURIDENT",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themeProvider.darkopp,
                fontSize: 30.sp,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => handleCaseTap(0),
                  onTapCancel: handleCaseTapCancel,
                  child: Transform(
                    transform: Matrix4.translationValues(0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedCaseIndex == 0
                              ? const Color(0xffC99F4A)
                              : const Color(0xff050125),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 2, color: themeProvider.bordercolor)),
                      width: screenWidth > 380 ? 120 : 100,
                      height: screenHeight > 615 ? 120 : 100,
                      child: Center(
                        child: Text(
                          '${openCasesLists.length} \nOpen\ncases',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: selectedCaseIndex == 0
                                ? Colors.black
                                : const Color(0xffC99F4A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () => handleCaseTap(1),
                  onTapCancel: handleCaseTapCancel,
                  child: Transform(
                    transform: Matrix4.translationValues(0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedCaseIndex == 1
                              ? const Color(0xffC99F4A)
                              : const Color(0xff050125),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 2, color: themeProvider.bordercolor)),
                      width: screenWidth > 380 ? 120 : 100,
                      height: screenHeight > 615 ? 120 : 100,
                      child: Center(
                        child: Text(
                          '${closedCasesLists.length} \nClosed\ncases',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: selectedCaseIndex == 1
                                ? Colors.black
                                : const Color(0xffC99F4A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () => handleCaseTap(2),
                  onTapCancel: handleCaseTapCancel,
                  child: Transform(
                    transform: Matrix4.translationValues(0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedCaseIndex == 2
                              ? const Color(0xffC99F4A)
                              : const Color(0xff050125),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 2, color: themeProvider.bordercolor)),
                      width: screenWidth > 380 ? 120 : 100,
                      height: screenHeight > 615 ? 120 : 100,
                      child: Center(
                        child: Text(
                          '${upcomingCasesLists.length} \nUpcoming\ncases',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: selectedCaseIndex == 2
                                ? Colors.black
                                : const Color(0xffC99F4A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isListViewVisible && selectedCaseIndex == 0)
              Expanded(
                child: Transform(
                  transform: Matrix4.translationValues(0, 60, 0),
                  child: SizedBox(
                    width: screenWidth > 380 ? 380 : screenWidth,
                    height: screenHeight > 615 ? 615 : screenHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: openCasesLists.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> caseData = openCasesLists[index];
                          final caseName = caseData['caseName'] ?? '';
                          final partyName = caseData['partyName'] ?? '';
                          final caseNumber = caseData['caseNo'] ?? '';
                          return LandingItemWidget(
                            caseName: caseName,
                            partyName: partyName,
                            caseNumber: caseNumber,
                            caseType: 'open',
                            lawyerName: lawyerName,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            if (isListViewVisible && selectedCaseIndex == 1)
              Expanded(
                child: Transform(
                  transform: Matrix4.translationValues(0, 60, 0),
                  child: SizedBox(
                    width: screenWidth > 380 ? 380 : screenWidth,
                    height: screenHeight > 615 ? 615 : screenHeight,
                    child: ListView.builder(
                      itemCount: closedCasesLists.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> caseData = closedCasesLists[index];
                        final caseName = caseData['caseName'] ?? '';
                        final partyName = caseData['partyName'] ?? '';
                        final caseNumber = caseData['caseNo'] ?? '';
                        return LandingItemWidget(
                          caseName: caseName,
                          partyName: partyName,
                          caseNumber: caseNumber,
                          caseType: 'closed',
                          lawyerName: lawyerName,
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (isListViewVisible && selectedCaseIndex == 2)
              Expanded(
                child: Transform(
                  transform: Matrix4.translationValues(0, 60, 0),
                  child: SizedBox(
                    width: screenWidth > 380 ? 380 : screenWidth,
                    height: screenHeight > 615 ? 615 : screenHeight,
                    child: ListView.builder(
                      itemCount: upcomingCasesLists.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> caseData =
                            upcomingCasesLists[index];
                        final caseName = caseData['caseName'] ?? '';
                        final partyName = caseData['partyName'] ?? '';
                        final caseNumber = caseData['caseNo'] ?? '';
                        return LandingItemWidget(
                          caseName: caseName,
                          partyName: partyName,
                          caseNumber: caseNumber,
                          caseType: 'upcoming',
                          lawyerName: lawyerName,
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (!isListViewVisible)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 18.w, right: 18.w),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  border: Border.all(
                    color: Colors.yellow,
                    width: 1,
                  ),
                  color: const Color(0xFF050125),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Quick Access',
                    style: TextStyle(
                      color: const Color(0xFFC99F4A),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            if (!isListViewVisible)
              Transform(
                transform: Matrix4.translationValues(0, -93.8.h, 0),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    border: Border.all(
                      color: themeProvider.nextButtonColor,
                    ),
                  ),
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 20.h, top: 20.h),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 30.0.h,
                    crossAxisSpacing: 15.0.w,
                    children: [
                      QuickAccessButton(
                        imagePath: 'assets/images/icons/allcases.png',
                        label: 'Shared Cases',
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: SharedCasesPage());
                        },
                      ),
                      QuickAccessButton(
                        imagePath: 'assets/images/icons/addcase.png',
                        label: 'Add Case',
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: newcase_form());
                        },
                      ),
                      QuickAccessButton(
                        imagePath: 'assets/images/icons/tasks.png',
                        label: 'Tasks',
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: tasks());
                        },
                      ),
                      QuickAccessButton(
                        imagePath: 'assets/images/icons/sharedfiles.png',
                        label: 'Shared Files',
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: const Myfiles());
                        },
                      ),
                      QuickAccessButton(
                        imagePath: 'assets/images/icons/events.png',
                        label: 'Events',
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: const Calendar());
                        },
                      ),
                      QuickAccessButton(
                        imagePath: 'assets/images/icons/faq.png',
                        label: 'FAQ',
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: faq());
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class QuickAccessButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const QuickAccessButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: themeProvider.nextButtonColor,
        backgroundColor: themeProvider.notesbackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: BorderSide(
          color: themeProvider.nextButtonColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 27.0.w,
            height: 27.0.h,
          ),
          SizedBox(height: 8.0.h),
          Text(
            label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
