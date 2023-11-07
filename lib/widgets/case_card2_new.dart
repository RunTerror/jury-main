// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:juridentt/resources/check_permission.dart';
// import 'package:juridentt/resources/directory_path.dart';
// import 'package:open_file/open_file.dart';

// class NewCaseCard2 extends StatefulWidget {
//   final String caseName;
//   final String lawyerName;
//   final String lawyerPhoneNumber;
//   final String lawyerEmail;
//   final String caseNo;
//   final String partyName;
//   final String fileName;
//   final String fileUrl;

//   const NewCaseCard2({
//     Key? key,
//     required this.caseName,
//     required this.partyName,
//     required this.caseNo,
//     required this.lawyerEmail,
//     required this.lawyerName,
//     required this.lawyerPhoneNumber,
//     required this.fileName,
//     required this.fileUrl,
//   }) : super(key: key);

//   @override
//   State<NewCaseCard2> createState() => _NewCaseCard2State();
// }

// class _NewCaseCard2State extends State<NewCaseCard2> {
//   bool isBookmarked = false;
//   bool downloading = false;
//   bool fileExists = false;
//   double progress = 0;
//   late String filePath;
//   late CancelToken cancelToken;
//   late String fileName;

//   final yellow = const Color(0xFFC99F4A);
//   var checkAllPermissions = CheckPermission();
//   var getPathFile = DirectoryPath();

//   @override
//   void initState() {
//     super.initState();
//     fileName = widget.fileName;
//     checkFileExist();
//   }

//   checkFileExist() async {
//     var storePath = await getPathFile.getPath();
//     filePath = '$storePath/$fileName';
//     bool fileExistCheck = await File(filePath).exists();
//     setState(() {
//       fileExists = fileExistCheck;
//     });
//   }

//   startDownload() async {
//     cancelToken = CancelToken();
//     var storePath = await getPathFile.getPath();
//     filePath = '$storePath/$fileName';
//     setState(() {
//       downloading = true;
//       progress = 0;
//     });

//     try {
//       await Dio().download(
//         widget.fileUrl,
//         filePath,
//         onReceiveProgress: (count, total) {
//           setState(() {
//             progress = (count / total);
//           });
//         },
//         cancelToken: cancelToken,
//       );
//       setState(() {
//         downloading = false;
//         fileExists = true;
//       });
//     } catch (e) {
//       // print(e);
//       if (e.toString().contains("404")) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) => const AlertDialog(
//             content: Text(
//               'File Not Found',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             backgroundColor: Color(0xFFC99F4A),
//           ),
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) => const AlertDialog(
//             content: Text(
//               'Something went wrong',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             backgroundColor: Color(0xFFC99F4A),
//           ),
//         );
//       }
//       setState(() {
//         downloading = false;
//       });
//     }
//   }

//   cancelDownload() {
//     cancelToken.cancel();
//     setState(() {
//       downloading = false;
//     });
//   }

//   openFile() {
//     OpenFile.open(filePath);
//     // print("File Path: $filePath");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black,
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10, bottom: 10),
//           child: Stack(
//             children: [
//               Container(
//                 width: 383,
//                 height: 229,
//                 decoration: ShapeDecoration(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(width: 0.50),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   shadows: const [
//                     BoxShadow(
//                       color: Color(0x3F000000),
//                       blurRadius: 4,
//                       offset: Offset(0, 4),
//                       spreadRadius: 0,
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(20, 10, 0),
//                 child: Text(
//                   widget.caseName,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 22,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Transform(
//                 transform: Matrix4.translationValues(250, 0, 0),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(87.96, 24.91),
//                     backgroundColor: yellow,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.only(top: 5),
//                     child: Text(
//                       "View",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Satoshi',
//                         fontSize: 14,
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Transform(
//                 transform: Matrix4.translationValues(335, 0, 0),
//                 child: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       if (!isBookmarked) {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) => const AlertDialog(
//                             content: Text(
//                               'Bookmarked Successfully',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             backgroundColor: Color(0xFFC99F4A),
//                           ),
//                         );
//                       } else {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) => const AlertDialog(
//                             content: Text(
//                               'Removed from Bookmarks',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             backgroundColor: Color(0xFFC99F4A),
//                           ),
//                         );
//                       }
//                       isBookmarked = !isBookmarked;
//                     });
//                   },
//                   icon: const Icon(Icons.bookmark_add_outlined),
//                   color: isBookmarked ? yellow : Colors.black,
//                 ),
//               ),
//               Transform(
//                 transform: Matrix4.translationValues(20, 55, 0),
//                 child: Image.asset("assets/images/user-circle.png"),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(95, 65, 0),
//                 child: Text(
//                   widget.lawyerName,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 16,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(95, 90, 0),
//                 child: Text(
//                   widget.lawyerPhoneNumber,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(40, 120, 0),
//                 child: const Text(
//                   "Email : ",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(80, 120, 0),
//                 child: Text(
//                   widget.lawyerEmail,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(40, 140, 0),
//                 child: const Text(
//                   "Case Number : ",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(120, 140, 0),
//                 child: Text(
//                   widget.caseNo,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(40, 160, 0),
//                 child: const Text(
//                   "File Name : ",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(110, 160, 0),
//                 child: Text(
//                   widget.fileName,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(40, 180, 0),
//                 child: const Text(
//                   "Party Name : ",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(110, 180, 0),
//                 child: Text(
//                   widget.partyName,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Satoshi',
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Transform(
//                 transform: Matrix4.translationValues(250, 40, 0),
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     // print(widget.fileUrl);
//                     if (fileExists) {
//                       openFile();
//                     } else {
//                       startDownload();
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     fixedSize: const Size(118.68, 25),
//                     backgroundColor: Colors.black,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 5),
//                     child: Row(
//                       children: [
//                         Image.asset("assets/images/download.png"),
//                         const Text(
//                           "Download Info",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color(0xFFC99F4A),
//                             fontFamily: 'Satoshi',
//                             fontSize: 10,
//                             fontStyle: FontStyle.normal,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(240, 90, 0),
//                 height: 111,
//                 width: 131.38,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/case_image.png"),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/resources/check_permission.dart';
import 'package:juridentt/resources/directory_path.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class NewCaseCard2 extends StatefulWidget {
  final String caseName;
  final String lawyerName;
  final String lawyerPhoneNumber;
  final String lawyerEmail;
  final String caseNo;
  final String partyName;
  final String fileName;
  final String fileUrl;

  const NewCaseCard2({
    Key? key,
    required this.caseName,
    required this.partyName,
    required this.caseNo,
    required this.lawyerEmail,
    required this.lawyerName,
    required this.lawyerPhoneNumber,
    required this.fileName,
    required this.fileUrl,
  }) : super(key: key);

  @override
  State<NewCaseCard2> createState() => _NewCaseCard2State();
}

class _NewCaseCard2State extends State<NewCaseCard2> {
  bool isBookmarked = false;
  bool downloading = false;
  bool fileExists = false;
  double progress = 0;
  late String filePath;
  late CancelToken cancelToken;
  late String fileName;

  final yellow = const Color(0xFFC99F4A);
  var checkAllPermissions = CheckPermission();
  var getPathFile = DirectoryPath();

  @override
  void initState() {
    super.initState();
    fileName = widget.fileName;
    checkFileExist();
    checkBookmarkStatus();
  }

  checkFileExist() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      downloading = true;
      progress = 0;
    });

    try {
      await Dio().download(
        widget.fileUrl,
        filePath,
        onReceiveProgress: (count, total) {
          setState(() {
            progress = (count / total);
          });
        },
        cancelToken: cancelToken,
      );
      setState(() {
        downloading = false;
        fileExists = true;
      });
    } catch (e) {
      // print(e);
      if (e.toString().contains("404")) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const AlertDialog(
            content: Text(
              'File Not Found',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            backgroundColor: Color(0xFFC99F4A),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => const AlertDialog(
            content: Text(
              'Something went wrong',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            backgroundColor: Color(0xFFC99F4A),
          ),
        );
      }
      setState(() {
        downloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      downloading = false;
    });
  }

  openFile() {
    OpenFile.open(filePath);
    print("File Path: $filePath");
  }

  Widget buildDownloadButtonChild() {
    if (fileExists) {
      return const Row(
        children: [
          Icon(
            Icons.open_in_new_outlined,
            color: Color(0xFFC99F4A),
            size: 15,
          ),
          Text(
            "Open File",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFC99F4A),
              fontFamily: 'Satoshi',
              fontSize: 10,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    } else if (downloading) {
      return CircularProgressIndicator(
        value: progress,
        color: yellow,
        strokeWidth: 2.0,
      );
    } else {
      return Row(
        children: [
          Image.asset("assets/images/download.png"),
          const Text(
            "Download Info",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFC99F4A),
              fontFamily: 'Satoshi',
              fontSize: 10,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }
  }

  // Check the bookmark status of the file
  checkBookmarkStatus() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    bool bookmarked = await FirebaseFirestore.instance
        .collection('lawyers')
        .doc(userId)
        .collection('bookmarks')
        .where('fileName', isEqualTo: widget.fileName)
        .where('fileUrl', isEqualTo: widget.fileUrl)
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.isNotEmpty);
    setState(() {
      isBookmarked = bookmarked; // Update isBookmarked
    });
  }

  bookMark() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    if (isBookmarked) {
      // If the file is already bookmarked, remove it from bookmarks
      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(userId)
          .collection('bookmarks')
          .where('fileName', isEqualTo: widget.fileName)
          .where('fileUrl', isEqualTo: widget.fileUrl)
          .get()
          .then((QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      // Remove the file from the bookmarked files directory
      var appDir = await getApplicationDocumentsDirectory();
      var bookmarkedFilesDir =
          Directory(path.join(appDir.path, 'bookmarked_files'));
      String fileName = path.basename(widget.fileUrl);
      var file = File(path.join(bookmarkedFilesDir.path, fileName));
      if (await file.exists()) {
        await file.delete();
      }

      setState(() {
        isBookmarked = false; // Update isBookmarked
      });

      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          content: Text(
            'Removed from Bookmarks',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Color(0xFFC99F4A),
        ),
      );
    } else {
      // If the file is not bookmarked, add it to bookmarks
      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(userId)
          .collection('bookmarks')
          .add({
            'caseName': widget.caseName,
            'partyName': widget.partyName,
            'caseNo': widget.caseNo,
            'lawyerName': widget.lawyerName,
            'lawyerPhoneNumber': widget.lawyerPhoneNumber,
            'lawyerEmail': widget.lawyerEmail,
            'fileName': widget.fileName,
            'fileUrl': widget.fileUrl,
          })
          .then((value) => print("File bookmarked successfully"))
          .catchError((error) => print("Failed to bookmark file: $error"));

      // Get the application documents directory
      var appDir = await getApplicationDocumentsDirectory();

      // Create the bookmarked files directory if it doesn't exist
      var bookmarkedFilesDir =
          Directory(path.join(appDir.path, 'bookmarked_files'));
      if (!await bookmarkedFilesDir.exists()) {
        await bookmarkedFilesDir.create();
      }

      // Get the file name from the file URL
      String fileName = path.basename(widget.fileUrl);

      // Get the source file path
      var sourceFile = File(filePath);

      // Get the destination file path
      var destinationFile = File(path.join(bookmarkedFilesDir.path, fileName));

      // Copy the file to the bookmarked files directory
      if (await sourceFile.exists()) {
        // Copy the file to the bookmarked files directory
        try {
          await sourceFile.copy(destinationFile.path);
          print('File copied successfully');
        } catch (e) {
          print('Failed to copy file: $e');
        }
      } else {
        print('Source file does not exist');
      }

      setState(() {
        isBookmarked = true; // Update isBookmarked
      });

      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          content: Text(
            'Bookmarked Successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Color(0xFFC99F4A),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Stack(
            children: [
              Container(
                width: 383,
                height: 229,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(20, 10, 0),
                child: Text(
                  widget.caseName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 22,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(250, 0, 0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(87.96, 24.91),
                    backgroundColor: yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "View",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satoshi',
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(335, 0, 0),
                child: IconButton(
                  onPressed: () {
                    bookMark();
                  },
                  icon: const Icon(Icons.bookmark_add_outlined),
                  color: isBookmarked ? yellow : Colors.black,
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(20, 55, 0),
                child: Image.asset("assets/images/user-circle.png"),
              ),
              Container(
                transform: Matrix4.translationValues(95, 65, 0),
                child: Text(
                  widget.lawyerName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(95, 90, 0),
                child: Text(
                  widget.lawyerPhoneNumber,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(40, 120, 0),
                child: const Text(
                  "Email : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(80, 120, 0),
                child: Text(
                  widget.lawyerEmail,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(40, 140, 0),
                child: const Text(
                  "Case Number : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(120, 140, 0),
                child: Text(
                  widget.caseNo,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(40, 160, 0),
                child: const Text(
                  "File Name : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(110, 160, 0),
                child: Text(
                  widget.fileName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(40, 180, 0),
                child: const Text(
                  "Party Name : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(110, 180, 0),
                child: Text(
                  widget.partyName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(250, 40, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    // print(widget.fileUrl);
                    if (fileExists) {
                      openFile();
                    } else {
                      startDownload();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: const Size(118.68, 25),
                    backgroundColor: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: buildDownloadButtonChild(),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(240, 90, 0),
                height: 111,
                width: 131.38,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/case_image.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
