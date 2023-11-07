// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'navbar_provider.dart';

// // class Navbar extends StatelessWidget {
// //   const Navbar({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// // return
// //         return BottomAppBar(
// //           height: 40,

// //           shape:
// //               const CircularNotchedRectangle(), //represents a rectangular shape with a circular notch at the bottom
// //           color: Colors.black,
// //           notchMargin: 0,
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Row(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   MaterialButton(
// //                     onPressed: () {
// //                       navbarProvider.setCurrentTab(0);
// //                     },
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(
// //                           Icons.home,
// //                           color: currentTab == 0
// //                               ? const Color(0xFFC99F4A)
// //                               : Colors.white,
// //                         ),
// //                         Text(
// //                           'Home',
// //                           style: TextStyle(
// //                             color: currentTab == 0
// //                                 ? const Color(0xFFC99F4A)
// //                                 : Colors.white,
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                   MaterialButton(
// //                     onPressed: () {
// //                       navbarProvider.setCurrentTab(1);
// //                     },
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(
// //                           Icons.newspaper,
// //                           color: currentTab == 1
// //                               ? const Color(0xFFC99F4A)
// //                               : Colors.white,
// //                         ),
// //                         Text(
// //                           'News',
// //                           style: TextStyle(
// //                             color: currentTab == 1
// //                                 ? const Color(0xFFC99F4A)
// //                                 : Colors.white,
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               //Right Tab Bar Icons
// //               Row(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   MaterialButton(
// //                     onPressed: () {
// //                       navbarProvider.setCurrentTab(2);
// //                     },
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(
// //                           Icons.calendar_month,
// //                           color: currentTab == 2
// //                               ? const Color(0xFFC99F4A)
// //                               : Colors.white,
// //                         ),
// //                         Text(
// //                           'Calendar',
// //                           style: TextStyle(
// //                             color: currentTab == 2
// //                                 ? const Color(0xFFC99F4A)
// //                                 : Colors.white,
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                   MaterialButton(
// //                     onPressed: () {
// //                       navbarProvider.setCurrentTab(3);
// //                     },
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(
// //                           Icons.person,
// //                           color: currentTab == 3
// //                               ? const Color(0xFFC99F4A)
// //                               : Colors.white,
// //                         ),
// //                         Text(
// //                           'Account',
// //                           style: TextStyle(
// //                             color: currentTab == 3
// //                                 ? const Color(0xFFC99F4A)
// //                                 : Colors.white,
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         );

// // return
// // BottomAppBar(
// //   height: 20,
// //   shape: const CircularNotchedRectangle(),
// //   color: Colors.black,
// //   notchMargin: 0,
// //   child: SizedBox(
// //     child: Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceAround,
// //       children: [
// //         IconButton(
// //           onPressed: () {
// //             navbarProvider.setCurrentTab(0);
// //           },
// //           icon: Icon(
// //             Icons.home,
// //             color: currentTab == 0
// //                 ? const Color(0xFFC99F4A)
// //                 : Colors.white,
// //           ),
// //         ),
// //         IconButton(
// //           onPressed: () {
// //             navbarProvider.setCurrentTab(1);
// //           },
// //           icon: Icon(
// //             Icons.newspaper,
// //             color: currentTab == 1
// //                 ? const Color(0xFFC99F4A)
// //                 : Colors.white,
// //           ),
// //         ),
// //         IconButton(
// //           onPressed: () {
// //             navbarProvider.setCurrentTab(2);
// //           },
// //           icon: Icon(
// //             Icons.calendar_today,
// //             color: currentTab == 2
// //                 ? const Color(0xFFC99F4A)
// //                 : Colors.white,
// //           ),
// //         ),
// //         IconButton(
// //           onPressed: () {
// //             navbarProvider.setCurrentTab(3);
// //           },
// //           icon: Icon(
// //             Icons.person,
// //             color: currentTab == 3
// //                 ? const Color(0xFFC99F4A)
// //                 : Colors.white,
// //           ),
// //         ),
// //       ],
// //     ),
// //   ),
// // );
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'navbar_provider.dart';
// import 'package:provider/provider.dart';

// class navbar extends StatelessWidget {
//   const navbar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const yellow = Color(0xFFC99F4A);
//     return Consumer<NavbarProvider>(
//       builder: (context, navbarProvider, _) {
//         final currentTab = navbarProvider.currentTab;
//         return Material(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 200),
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 65,
//                     width: 428,
//                     decoration: const BoxDecoration(
//                         color: Color(0xff333333),
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20))),
//                   ),
//                   Column(
//                     children: [
//                       Transform(
//                         transform: Matrix4.translationValues(0, -25, 0),
//                         child: FloatingActionButton(
//                           backgroundColor: yellow,
//                           onPressed: () {},
//                           child: const Icon(
//                             Icons.add,
//                             color: Colors.white,
//                             size: 35,
//                           ),
//                         ),
//                       ),
//                       Transform(
//                         transform: Matrix4.translationValues(0, -45, 0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 MaterialButton(
//                                   onPressed: () {},
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         Icons.home,
//                                         color: currentTab == 0
//                                             ? const Color(0xFFC99F4A)
//                                             : Colors.white,
//                                       ),
//                                       Text(
//                                         'Home',
//                                         style: TextStyle(
//                                           color: currentTab == 0
//                                               ? const Color(0xFFC99F4A)
//                                               : Colors.white,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 MaterialButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       currentTab = 1;
//                                     });
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         Icons.newspaper,
//                                         color: currentTab == 1
//                                             ? const Color(0xFFC99F4A)
//                                             : Colors.white,
//                                       ),
//                                       Text(
//                                         'News',
//                                         style: TextStyle(
//                                           color: currentTab == 1
//                                               ? const Color(0xFFC99F4A)
//                                               : Colors.white,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             //Right Tab Bar Icons
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MaterialButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       currentTab = 2;
//                                     });
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         Icons.calendar_month,
//                                         color: currentTab == 2
//                                             ? const Color(0xFFC99F4A)
//                                             : Colors.white,
//                                       ),
//                                       Text(
//                                         'Calendar',
//                                         style: TextStyle(
//                                           color: currentTab == 2
//                                               ? const Color(0xFFC99F4A)
//                                               : Colors.white,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 MaterialButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       currentTab = 3;
//                                     });
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         Icons.person,
//                                         color: currentTab == 3
//                                             ? const Color(0xFFC99F4A)
//                                             : Colors.white,
//                                       ),
//                                       Text(
//                                         'Account',
//                                         style: TextStyle(
//                                           color: currentTab == 3
//                                               ? const Color(0xFFC99F4A)
//                                               : Colors.white,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
