// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:juridentt/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:juridentt/addcase/provider.dart';

FirebaseFirestore _store = FirebaseFirestore.instance;

class TeamsPage extends StatefulWidget {
  final String casetype;
  final String casenumber;
  static const String routename = 'teams';
  const TeamsPage(
      {super.key, required this.casenumber, required this.casetype});

  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  var access_screen_background_color = 0xffffffff;
  var searchbar_accesspage_color = 0xfff5f5f5;
  var serach_result_tile_color = 0xff616161;
  var can_edit_button_access_page = 0xffffffff;
  var selectedValue = 'all';
  // var casenumber = 109;
  var accesslist = [
    '',
  ];
  bool svalue = true;

  TextEditingController searchfield = TextEditingController();

  List<Info> filteredItems = [];

  get casenumber => null;

  @override
  void initState() {
    super.initState();
  }

  void updateTeamList() async {
    await _store
        .collection(widget.casetype)
        .where('caseNo', isEqualTo: widget.casenumber)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var caseDoc = querySnapshot.docs[0].reference;
        caseDoc.update({'team': accesslist});
      }
    });
  }

  void updatelawyercases(String caseno, String mobileNumber, int mode) async {
    var caseref = _store
        .collection(widget.casetype)
        .where('caseNo', isEqualTo: widget.casenumber);

    await _store
        .collection('lawyers')
        .where('mobileNumber', isEqualTo: mobileNumber)
        .get()
        .then((querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        if (mode == 1) {
          var id = querySnapshot.docs[0].id;
          var lawyerMobileNumber = querySnapshot.docs[0].data()['mobileNumber'];
          print(lawyerMobileNumber);
          await _store.collection('lawyers').doc(id).update({
            'sharedcases': FieldValue.arrayUnion([caseno])
          });
          caseref.get().then((querySnapshot) {
            if (querySnapshot.docs.isNotEmpty) {
              var caseDoc = querySnapshot.docs[0].reference;
              caseDoc.update({
                'team': FieldValue.arrayUnion([lawyerMobileNumber])
              });
            }
          });
        } else {
          var id = querySnapshot.docs[0].id;
          var lawyerMobileNumber = querySnapshot.docs[0].data()['mobileNumber'];
          await _store.collection('lawyers').doc(id).update({
            'sharedcases': FieldValue.arrayRemove([caseno])
          });
          caseref.get().then((querySnapshot) {
            if (querySnapshot.docs.isNotEmpty) {
              var caseDoc = querySnapshot.docs[0].reference;
              caseDoc.update({
                'team': FieldValue.arrayRemove([lawyerMobileNumber])
              });
            }
          });
        }
      }
    });
  }

  void fetchSearchResults(String query) async {
    if (query.isNotEmpty) {
      await _store
          .collection(widget.casetype)
          .where('caseNo', isEqualTo: widget.casenumber)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          var caseDoc = querySnapshot.docs[0].reference;
          caseDoc.get().then((documentSnapshot) {
            var data = documentSnapshot.data();

            accesslist = (data != null && data.containsKey('team'))
                ? List<String>.from(data['team'])
                : [];
            // await _store
            //     .collection('lawyers')
            //     .where('mobileNumber',
            //         isGreaterThanOrEqualTo: query,
            //         isLessThan: query.substring(0, query.length - 1) +
            //             String.fromCharCode(
            //                 query.codeUnitAt(query.length - 1) + 1))
            //     .where('mobileNumber', whereIn: accesslist)
            //     .get()
            //     .then((querySnapshot) {
            //   if (querySnapshot.docs.isNotEmpty) {
            //     setState(() {
            //       filteredItems = querySnapshot.docs
            //           .map((document) => Info.fromDocumentSnapshot(document))
            //           .toList();
            //     });
            //   } else {
            //     setState(() {
            //       filteredItems = [];
            //     });
            //   }
            // });
          });
        } else {
          setState(() {
            filteredItems = [];
          });
        }
      });

      if (selectedValue == 'can edit') {
        // await _store
        //     .collection(widget.casetype)
        //     .where('caseNo', isEqualTo: widget.casenumber)
        //     .get()
        //     .then((querySnapshot) {
        //   if (querySnapshot.docs.isNotEmpty) {
        //     var caseDoc = querySnapshot.docs[0].reference;
        //     caseDoc.get().then((documentSnapshot) {
        //       var data = documentSnapshot.data();

        //       accesslist = (data != null && data.containsKey('team'))
        //           ? List<String>.from(data['team'])
        //           : [];
        await _store
            .collection('lawyers')
            .where('mobileNumber',
                isGreaterThanOrEqualTo: query,
                isLessThan: query.substring(0, query.length - 1) +
                    String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
            .where('mobileNumber', whereIn: accesslist)
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              filteredItems = querySnapshot.docs
                  .map((document) => Info.fromDocumentSnapshot(document))
                  .toList();
            });
          } else {
            setState(() {
              filteredItems = [];
            });
          }
        });
        //     });
        //   } else {
        //     setState(() {
        //       filteredItems = [];
        //     });
        //   }
        // });
      } else if (selectedValue == 'all') {
        await _store
            .collection('lawyers')
            .where('mobileNumber',
                isGreaterThanOrEqualTo: query,
                isLessThan: query.substring(0, query.length - 1) +
                    String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              filteredItems = querySnapshot.docs
                  .map((document) => Info.fromDocumentSnapshot(document))
                  .toList();
            });
          } else {
            setState(() {
              filteredItems = [];
            });
          }
        });
      } else {
        await _store
            .collection('lawyers')
            .where('mobileNumber',
                isGreaterThanOrEqualTo: query,
                isLessThan: query.substring(0, query.length - 1) +
                    String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
            .where('mobileNumber', whereNotIn: accesslist)
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              filteredItems = querySnapshot.docs
                  .map((document) => Info.fromDocumentSnapshot(document))
                  .toList();
            });
          } else {
            setState(() {
              filteredItems = [];
            });
          }
        });
      }
    } else {
      setState(() {
        filteredItems = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('access page'),
      //   backgroundColor: Color(access_screen_background_color),
      // ),
      backgroundColor: Color(access_screen_background_color),
      body: Container(
        decoration:
            BoxDecoration(gradient: themeProvider.scaffoldGradientscrol),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 70.h, bottom: 10.h, left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: TextField(
                            autocorrect: true,
                            controller: searchfield,
                            decoration: InputDecoration(
                              hintText: 'Enter Phone number',
                              // fillColor: themeProvider.casestext,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.0)),
                                  borderSide:
                                      BorderSide(color: themeProvider.editext)),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                            onChanged: (string) {
                              fetchSearchResults(string);
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: const Color(0xffffffff),
                          ),
                          child: DropdownButton(
                            //  dropdownColor: const Color(0xffffffff),
                            value: selectedValue,
                            items: const <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: 'can edit',
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('can edit'),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'cannot edit',
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('cannot edit'),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'all',
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('all'),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                // print(searchfield.text);
                                fetchSearchResults(searchfield.text);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const Icon(Icons.search_outlined)
                ],
              ),
            ),
            Expanded(
                child: filteredItems.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              height: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color(0xff616161),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        '${filteredItems[index].name}(${filteredItems[index].mobileNumber})'),
                                  ),
                                  Switch(
                                    value: accesslist.contains(
                                      filteredItems[index].mobileNumber,
                                    )
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          if (value) {
                                            accesslist.add(filteredItems[index]
                                                .mobileNumber);
                                            updatelawyercases(
                                                widget.casenumber.toString(),
                                                filteredItems[index]
                                                    .mobileNumber,
                                                1);
                                            updateTeamList();
                                          } else {
                                            accesslist.remove(
                                                filteredItems[index]
                                                    .mobileNumber);
                                            updatelawyercases(
                                                widget.casenumber.toString(),
                                                filteredItems[index]
                                                    .mobileNumber,
                                                2);
                                            updateTeamList();
                                          }
                                        },
                                      );
                                      fetchSearchResults(searchfield.text);
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('No results found'))),
          ],
        ),
      ),
    );
  }
}
