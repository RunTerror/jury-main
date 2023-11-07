import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/files/myfile.dart';
import 'package:juridentt/widgets/case_card2_new.dart';
import 'package:provider/provider.dart';

import '../addcase/provider.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List<Map<String, dynamic>> fileDatas = [];

  @override
  void initState() {
    super.initState();
    getBookmarks();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> getBookmarks() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('lawyers')
        .doc(userId)
        .collection('bookmarks')
        .get();

    List<Map<String, dynamic>> data = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    setState(() {
      fileDatas = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //  backgroundColor: Colors.black,
        body: Container(
          decoration:
              BoxDecoration(gradient: themeProvider.scaffoldGradientscrol),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Transform(
                  transform: Matrix4.translationValues(0, 10, 0),
                  child: Text(
                    "JURIDENT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xffC99F4A),
                      fontSize: 30.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(-130, 25, 0),
                  child: Text(
                    " Book Marks",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xffC99F4A),
                      fontSize: 26.sp,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                SizedBox(height: 60.h),
                Container(
                  height: 101.h,
                  width: size.width,
                  decoration: const ShapeDecoration(
                    // color: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0, color: Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Transform(
                            transform: Matrix4.translationValues(20, 30, 0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fixedSize: const Size(127, 38),
                                  backgroundColor: const Color(0xFFC99F4A)),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/bookmark.png"),
                                  SizedBox(
                                    width: 7.w,
                                  ),
                                  Text(
                                    'Bookmarks',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 80.w),
                          Transform(
                            transform: Matrix4.translationValues(0, 30, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(90, 38),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color(0xFFC99F4A)),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Image.asset("assets/images/filter.png"),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(5, 30, 0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(90.w, 38.h),
                                  backgroundColor: const Color(0xFFC99F4A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/sort.png"),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Sort',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                      // color: Colors.black,
                      ),
                  child: fileDatas.isEmpty
                      ? Column(
                          children: [
                            SizedBox(height: 40.h),
                            Image.asset(
                              "assets/images/nofiles.png",
                              height: 200.h,
                              width: 200.w,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'No Bookmarks',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'You have not added any Bookmarks yet',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(127, 26),
                                  backgroundColor: const Color(0xFFC99F4A)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Myfiles(),
                                  ),
                                );
                              },
                              child: Text(
                                'Files',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 17.h);
                          },
                          itemCount: fileDatas.length,
                          itemBuilder: (context, index) {
                            final userData = fileDatas[index];
                            final casename = userData['caseName'] ?? '';
                            final casenumber = userData['caseNo'] ?? '';
                            final partyname = userData['partyName'] ?? '';
                            final lawyername = userData['lawyerName'] ?? '';
                            final lawyeremail = userData['lawyerEmail'] ?? '';
                            final lawyerphonenumber =
                                userData['lawyerPhoneNumber'] ?? '';
                            final filename = userData['fileName'] ?? '';
                            final fileurl = userData['fileUrl'] ?? '';
                            return NewCaseCard2(
                              caseName: casename,
                              lawyerName: lawyername,
                              lawyerPhoneNumber: lawyerphonenumber,
                              lawyerEmail: lawyeremail,
                              caseNo: casenumber,
                              partyName: partyname,
                              fileName: filename,
                              fileUrl: fileurl,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
