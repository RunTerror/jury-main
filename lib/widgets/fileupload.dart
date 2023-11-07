// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// class AppFilePicker extends StatefulWidget {
//   final String title;
//   final Function(List<File>) onFilesSelected;
//   final String buttonText;

//   const AppFilePicker({
//     Key? key,
//     required this.title,
//     required this.onFilesSelected,
//     required this.buttonText,
//   }) : super(key: key);

//   @override
//   State<AppFilePicker> createState() => _AppFilePickerState();
// }

// class _AppFilePickerState extends State<AppFilePicker> {
//   List<File> selectedFiles = [];
//   double uploadProgress = 0.0;
//   bool showUploadDialog = false;

//   Future<void> _selectFiles() async {

//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg', 'heic'],
//     );

//     if (result != null) {
//       setState(() {
//         selectedFiles = result.paths.map((path) => File(path!)).toList();
//         uploadProgress = 0.0; // Reset progress when new files are selected
//       });

//       // Replace with your desired implementation for file upload
//       const totalDuration = Duration(seconds: 5);
//       const intervalDuration = Duration(milliseconds: 500);
//       int intervals =
//           totalDuration.inMilliseconds ~/ intervalDuration.inMilliseconds;
//       double stepProgress = 100 / intervals;

//       for (int i = 1; i <= intervals; i++) {
//         await Future.delayed(intervalDuration);
//         setState(() {
//           uploadProgress = stepProgress * i;
//         });
//       }

//       // Show the AlertDialog when upload is complete
//       if (uploadProgress == 100) {
//         widget.onFilesSelected(selectedFiles);
//         setState(() {
//           showUploadDialog = true;
//         });
//         await showDialog(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             content: SizedBox(
//               width: 330, // Set the desired width
//               height: 200, // Set the desired height
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Uploaded Successfully',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     width: 130,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size(130, 50),
//                         backgroundColor: const Color(0XFFFECE2F),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Done ",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Icon(
//                             Icons.done,
//                             size: 18,
//                             color: Colors.black,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(0.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (uploadProgress > 0 && uploadProgress < 100)
//             AlertDialog(
//               content: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 width: 330, // Set the desired width
//                 height: 200, // Set the desired height
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 16),
//                     Text(
//                       'Uploading ${uploadProgress.toStringAsFixed(0)}/100%',
//                       style: const TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     SizedBox(
//                       width: 130,
//                       height: 50,
//                       child: Container(
//                         width: 130,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: const Color(0XFFFECE2F),
//                           borderRadius: BorderRadius.circular(40),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "Loading",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
//             child: Text(
//               widget.title,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontFamily: 'Satoshi',
//                 fontWeight: FontWeight.normal,
//                 fontStyle: FontStyle.normal,
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: _selectFiles,
//             // child: Text(widget.buttonText),
//             child: Container(
//               margin: const EdgeInsets.only(left: 100),
//               width: 174,
//               decoration: BoxDecoration(
//                 color: const Color(0xffFFEABE),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   widget.buttonText,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AppFilePicker extends StatefulWidget {
  final String title;
  final Function(List<File>) onFilesSelected;
  final String buttonText;

  const AppFilePicker({
    Key? key,
    required this.title,
    required this.onFilesSelected,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<AppFilePicker> createState() => _AppFilePickerState();
}

class _AppFilePickerState extends State<AppFilePicker> {
  List<File> selectedFiles = [];
  double uploadProgress = 0.0;
  bool showUploadDialog = false;

  Future<void> _selectFiles() async {
    // Check if file picker is already open
    if (showUploadDialog) {
      return;
    }

    // Open file picker
    setState(() {
      showUploadDialog = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg', 'heic'],
    );

    if (result != null) {
      setState(() {
        selectedFiles = result.paths.map((path) => File(path!)).toList();
        uploadProgress = 0.0; // Reset progress when new files are selected
      });

      // Replace with your desired implementation for file upload
      const totalDuration = Duration(seconds: 5);
      const intervalDuration = Duration(milliseconds: 500);
      int intervals =
          totalDuration.inMilliseconds ~/ intervalDuration.inMilliseconds;
      double stepProgress = 100 / intervals;

      for (int i = 1; i <= intervals; i++) {
        await Future.delayed(intervalDuration);
        setState(() {
          uploadProgress = stepProgress * i;
        });
      }

      // Show the AlertDialog when upload is complete
      if (uploadProgress == 100) {
        widget.onFilesSelected(selectedFiles);
        setState(() {
          showUploadDialog = true;
        });
        await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: SizedBox(
              width: 330, // Set the desired width
              height: 200, // Set the desired height
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Uploaded Successfully',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 130,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(130, 50),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.done,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
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

    // Reset file picker state
    setState(() {
      showUploadDialog = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (uploadProgress > 0 && uploadProgress < 100)
            AlertDialog(
              content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                width: 330, // Set the desired width
                height: 200, // Set the desired height
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Uploading ${uploadProgress.toStringAsFixed(0)}/100%',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: Container(
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                          // color: const Color(0XFFFECE2F),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Center(
                          child: Text(
                            "Loading",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          InkWell(
            onTap: _selectFiles,
            // child: Text(widget.buttonText),
            child: Container(
              margin: const EdgeInsets.only(left: 100),
              width: 174,
              decoration: BoxDecoration(
                color: const Color(0xffFFEABE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
