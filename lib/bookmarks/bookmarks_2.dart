import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:juridentt/files/myfile.dart';
import 'package:provider/provider.dart';

import '../addcase/provider.dart';

class BookmarksPage2 extends StatefulWidget {
  const BookmarksPage2({super.key});

  @override
  State<BookmarksPage2> createState() => _BookmarksPage2State();
}

class _BookmarksPage2State extends State<BookmarksPage2> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
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
                    color: Colors.black,
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
                            transform: Matrix4.translationValues(10, 30, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(90.w, 38.h),
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
                            transform: Matrix4.translationValues(15, 30, 0),
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
                  width: 428.w,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 80.h),
                        child: Image.asset("assets/images/nofiles.png"),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      const Text(
                        'No Files Found',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFC99F4A),
                          fontSize: 30,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(127, 26),
                            backgroundColor: const Color(0xFFC99F4A)),
                        onPressed: () {
                          Get.to(() => const Myfiles());
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
                      )
                    ],
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
