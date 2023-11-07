// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/resources/check_permission.dart';
import 'package:juridentt/resources/directory_path.dart';
import 'package:open_file/open_file.dart';

class SharedfileWidget extends StatefulWidget {
  final String caseName;
  final String lawyerName;
  final String lawyerId;
  final String lawyerPhoneNumber;
  final String lawyerEmail;
  final String caseNo;
  final String partyName;
  final String fileName;
  final String fileUrl;

  const SharedfileWidget({
    Key? key,
    required this.caseName,
    required this.partyName,
    required this.caseNo,
    required this.lawyerId,
    required this.lawyerEmail,
    required this.lawyerName,
    required this.lawyerPhoneNumber,
    required this.fileName,
    required this.fileUrl,
  }) : super(key: key);

  @override
  State<SharedfileWidget> createState() => _SharedfileWidgetState();
}

class _SharedfileWidgetState extends State<SharedfileWidget> {
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
          Text(
            "Downloaded",
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: Color(0xFFC99F4A),
              color: Colors.black,
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
        // color: yellow,
        color: Colors.blue,
        strokeWidth: 2.0,
      );
    } else {
      return Row(
        children: [
          Image.asset(
            "assets/images/download.png",
            color: Colors.black,
          ),
          const Text(
            "Download Info",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Satoshi',
              fontSize: 9.7,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Container(
                height: 227,
                width: 383,

                //margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffD7FACE)),
              ),
              Transform(
                  transform: Matrix4.translationValues(10, 15, 0),
                  child: Image.asset("assets/images/Group_logo.png")),
              Transform(
                transform: Matrix4.translationValues(50, 15, 0),
                child: Text(
                  widget.caseName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 22,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Transform(
                  transform: Matrix4.translationValues(280, 20, 0),
                  child: Image.asset("assets/images/case_logo2.png")),
              Transform(
                  transform: Matrix4.translationValues(20, 70, 0),
                  child: Image.asset("assets/images/profile.png")),
              Transform(
                transform: Matrix4.translationValues(90, 80, 0),
                child: Text(
                  widget.lawyerName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(90, 110, 0),
                child: Text(
                  "Lawyer id : ${widget.lawyerId}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Satoshi',
                    fontSize: 11,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(20, 140, 0),
                child: Text(
                  "Email : ${widget.lawyerEmail}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(230, 140, 0),
                child: Text(
                  "Case Number : ${widget.caseNo}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(20, 165, 0),
                child: Text(
                  "File Name : ${widget.fileName}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(230, 165, 0),
                child: Text(
                  "Party Name : ${widget.partyName}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(10, 190, 0),
                child: SizedBox(
                  height: 24,
                  width: 115,
                  child: ElevatedButton(
                    onPressed: () {
                      startDownload();
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    // child: Row(
                    //   children: [
                    //     Image.asset(
                    //       "assets/images/download.png",
                    //       color: Colors.black,
                    //     ),
                    //     const Text(
                    //       "Download Info",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontFamily: 'Satoshi',
                    //         fontSize: 9.7,
                    //         fontStyle: FontStyle.normal,
                    //         fontWeight: FontWeight.normal,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: buildDownloadButtonChild(),
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(280, 190, 0),
                child: SizedBox(
                  height: 24,
                  width: 88,
                  child: ElevatedButton(
                    onPressed: () {
                      openFile();
                    },
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: const Text(
                      "View",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satoshi',
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
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
