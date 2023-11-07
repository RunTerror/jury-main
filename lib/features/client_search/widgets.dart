import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:provider/provider.dart';

import '../../addcase/constants.dart';

class CustomListTile extends StatelessWidget {
  // final TextEditingController controller;
  final String title;
  const CustomListTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)));
  }
}

// class ParentWidget extends StatefulWidget {

//   const ParentWidget({super.key});

//   @override
//   State<ParentWidget> createState() => _ParentWidgetState();
// }

// class _ParentWidgetState extends State<ParentWidget> {

//   bool isItalic = false;

//   void toggleItalic(){
//     setState(() {
//       isItalic=!isItalic;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class CustomeCaseNotes extends StatelessWidget {
  final bool isItalic;
  final String time;
  final String lawyerName;
  // final ValueChanged<bool> onButtonPressed;
  // final String message;
  final TextEditingController controller;
  const CustomeCaseNotes(
      {super.key,
      required this.isItalic,
      required this.lawyerName,
      required this.time,
      // required this.onButtonPressed,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return TextButton(
        onPressed: () {
          showModalBottomSheet<dynamic>(
              isScrollControlled: true,
              backgroundColor: themeProvider.notesbackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              context: context,
              builder: ((context) {
                return Wrap(children: [
                  SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.311,
                              right: screenWidth * 0.311),
                          child: Divider(
                            color: darkModeButtonColor,
                            thickness: 3,
                            height: 7,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.07,
                              top: screenHeight * 0.024),
                          child: Row(
                            children: [
                              const Text(
                                "Case Notes",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: screenWidth * 0.3,
                              ),
                              Container(
                                height: screenHeight * 0.04,
                                // width: screenWidth*0.0163,
                                decoration: BoxDecoration(
                                    color: themeProvider.darkModeButtonColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Save as Draft",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.039,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.07,
                          ),
                          child: Text(
                            "$lawyerName's Case Notes",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.07,
                              top: screenHeight * 0.024),
                          child: Text(
                            time,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            left: screenWidth * 0.07,
                            right: screenWidth * 0.07,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              // focusNode: node,
                              controller: controller,
                              maxLines: 18,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontStyle: isItalic
                                      ? FontStyle.italic
                                      : FontStyle.normal),
                              decoration: InputDecoration(
                                fillColor: formFillColor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),

                                // contentPadding:
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: screenHeight * 0.016,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: screenWidth * 0.07,
                        //       right: screenWidth * 0.07),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: formFillColor,
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Row(
                        //       children: [
                        //         TextButton(
                        //             onPressed: () {},
                        //             child: const Text(
                        //               "B",
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white,
                        //                   fontSize: 20),
                        //             )),
                        //         TextButton(
                        //             onPressed: () {
                        //               // onButtonPressed(!isItalic);
                        //             },
                        //             child: const Text(
                        //               "/",
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white,
                        //                   fontSize: 20),
                        //             )),
                        //         TextButton(
                        //             onPressed: () {},
                        //             child: const Text(
                        //               "U",
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white,
                        //                   fontSize: 20),
                        //             )),
                        //         // Spacer(),
                        //         SizedBox(
                        //           width: screenWidth * 0.067,
                        //         ),
                        //         InkWell(
                        //           onTap: () {},
                        //           child: Container(
                        //             height: 20,
                        //             width: 20,
                        //             decoration: BoxDecoration(
                        //                 border: Border.all(),
                        //                 borderRadius: BorderRadius.circular(20),
                        //                 color: Colors.red),
                        //             child: const Text(""),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: screenWidth * 0.067,
                        //         ),
                        //         IconButton(
                        //             onPressed: () {},
                        //             icon: const Icon(
                        //               Icons.menu_outlined,
                        //               color: Colors.white,
                        //             ))
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 8.h,
                        )
                      ],
                    ),
                  ),
                ]);
              }));
        },
        child: const Text("Show case notes"));
  }
}
