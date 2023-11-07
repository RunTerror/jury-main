// import 'package:flutter/material.dart';

// class Casecard extends StatefulWidget {
//   int case_num = 1234;
//   String case_name = "murder";
//   String party_name = "BJP";
//   Casecard(
//       {super.key,
//       required this.case_name,
//       required this.party_name,
//       required this.case_num});

//   @override
//   State<Casecard> createState() => _CasecardState();
// }

// class _CasecardState extends State<Casecard> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(0),
//       child: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: Container(
//               height: 140,
//               width: 410,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Color(0xFFC99F4A),
//                 border: Border.all(width: 3, color: Colors.black),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 120, top: 25),
//             child: Container(
//               height: 111,
//               width: 249,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 50, left: 140),
//                 child: Container(
//                   transform: Matrix4.translationValues(0, -10, 0),
//                   child: Text(
//                     "Case Number : ${widget.case_num}",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: 'Satoshi',
//                       fontSize: 14,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(75, 5, 0),
//                 child: Text(
//                   "Case Name : ${widget.case_name}",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 14,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(65, 20, 0),
//                 child: Text(
//                   "Party Name : ${widget.party_name}",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 14,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
