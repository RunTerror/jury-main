// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class LandingItemWidget extends StatelessWidget {
//   const LandingItemWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(
//         top: 14,
//         bottom: 14,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.yellow,
//         border: Border.all(
//           color: Colors.black,
//           width: 2,
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//             height: 111,
//             width: 118,
//             margin: const EdgeInsets.only(
//               bottom: 1,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(
//               bottom: 1,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 249,
//                   margin: const EdgeInsets.only(
//                     right: 1,
//                   ),
//                   padding: const EdgeInsets.only(
//                     left: 8,
//                     top: 16,
//                     right: 8,
//                     bottom: 16,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 1,
//                         ),
//                         child: RichText(
//                           text: const TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Case Number:  ",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "23-FA-12345",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 10,
//                         ),
//                         child: RichText(
//                           text: const TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Case",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: " ",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "Name:",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "Divorce Case",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 11,
//                           bottom: 3,
//                         ),
//                         child: RichText(
//                           text: const TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Party Name:",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: " ",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "Abhinav",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'casedetails.dart';

class LandingItemWidget extends StatelessWidget {
  final String caseNumber;
  final String caseName;
  final String partyName;
  final String caseType;
  final String lawyerName;

  const LandingItemWidget({
    Key? key,
    required this.caseNumber,
    required this.caseName,
    required this.partyName,
    required this.caseType,
    required this.lawyerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CaseDetailsPage(
              caseType: caseType,
              caseNumber: caseNumber,
              caseName: caseName,
              partyName: partyName,
              lawyerName: lawyerName,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5.w),
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffC99F4A),
          border: Border.all(
            color: Colors.black,
            width: 2.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 111.h,
              width: 109.h,
              margin: EdgeInsets.only(
                bottom: 1.h,
                left: 8.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  caseNumber,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 1.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.55,
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.h,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 1.w,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Case Number:  ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: caseNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.h,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Case",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: " ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "Name:",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: caseName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 11.h,
                            bottom: 3.h,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Party Name:",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: " ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: partyName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
