import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class Editcasenotes extends StatefulWidget {
  final String time;
  final String lawyerName;
  final String notes;

  const Editcasenotes({
    Key? key,
    required this.lawyerName,
    required this.time,
    required this.notes,
  }) : super(key: key);

  @override
  State<Editcasenotes> createState() => _EditcasenotesState();
}

class _EditcasenotesState extends State<Editcasenotes> {
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
            return Wrap(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.014),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.311,
                          right: screenWidth * 0.311,
                        ),
                        child: Divider(
                          color: darkModeButtonColor,
                          thickness: 3,
                          height: 7,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.07,
                          top: screenHeight * 0.024,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Case Notes",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                color: themeProvider.casestext,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.3),
                            // Container(
                            //   height: screenHeight * 0.04,
                            //   decoration: BoxDecoration(
                            //     color: themeProvider.notesbackground,
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   child: const Center(
                            //     child: Padding(
                            //       padding: EdgeInsets.all(8.0),
                            //       child: Text(
                            //         "Save as Draft",
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w500,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.039),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.07),
                        child: Text(
                          "${widget.lawyerName}'s Case Notes",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.editext,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.07,
                          top: screenHeight * 0.024,
                        ),
                        child: Text(
                          widget.time,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            initialValue: widget.notes,
                            onChanged: (value) {
                              final caseNotesProvider =
                                  Provider.of<CaseNotesProvider>(context,
                                      listen: false);
                              caseNotesProvider.casenotes = value;
                            },
                            // controller: controllerInput,
                            maxLines: 18,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                            decoration: InputDecoration(
                              fillColor: formFillColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Add your case notes",
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.016),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.07,
                          right: screenWidth * 0.07,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: formFillColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "B",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "/",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "U",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.067),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                  ),
                                  child: const Text(""),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.067),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.menu_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
      child: const Text("Show case notes"),
    );
  }
}
