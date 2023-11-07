// import 'package:flutter/material.dart';
// import 'package:juridentt/constants.dart';

// class Category extends StatelessWidget {
//   const Category({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Constants.orange,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Image(
//               image: AssetImage(
//                 'assets/images/jurident.png',
//               ),
//             ),
//             Container(
//               transform: Matrix4.translationValues(-60, -80, 0),
//               child: Text(
//                 'Choose your category',
//                 style: Constants.satoshiWhiteNormal23,
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                   color: Constants.white,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, '/lawyerlogin');
//                           },
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 150,
//                                 width: 150,
//                                 child: Image(
//                                   image: AssetImage('assets/images/lawyer.png'),
//                                 ),
//                               ),
//                               Text(
//                                 'Lawyer',
//                                 style: Constants.satoshiNormal30,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, '/clientlogin');
//                           },
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 150,
//                                 width: 150,
//                                 child: Image(
//                                   image: AssetImage('assets/images/client.png'),
//                                 ),
//                               ),
//                               Text(
//                                 'Client',
//                                 style: Constants.satoshiNormal30,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/constants.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.orange,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/jurident.png'),
            ),
            Container(
              transform: Matrix4.translationValues(-60, -60, 0),
              child: Text(
                'Choose your category',
                style: Constants.satoshiWhiteNormal23,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Constants.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/lawyerlogin');
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.2,
                            width: screenHeight * 0.2,
                            child: const Image(
                              image: AssetImage('assets/images/lawyer.png'),
                            ),
                          ),
                          Text(
                            'Lawyer',
                            style: Constants.satoshiNormal30,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/clientlogin');
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.2,
                            width: screenHeight * 0.2,
                            child: const Image(
                              image: AssetImage('assets/images/client.png'),
                            ),
                          ),
                          Text(
                            'Client',
                            style: Constants.satoshiNormal30,
                          ),
                        ],
                      ),
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
