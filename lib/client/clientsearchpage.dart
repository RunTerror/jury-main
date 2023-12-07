import 'package:juridentt/client/lawyerdetialspage.dart';
import 'package:juridentt/client/lawyerinfo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _store = FirebaseFirestore.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> filteredItems = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool isloading = false;

  void fetchSearchResults(String query, String atrribute) {
    if (query != '') {
      setState(() {
        isloading = true;
      });
      String queryUpper = query.toUpperCase();
      _store
          .collection('lawyers')
          .where(atrribute,
              isGreaterThanOrEqualTo: queryUpper,
              isLessThan: queryUpper.substring(0, query.length - 1) +
                  String.fromCharCode(
                      queryUpper.codeUnitAt(query.length - 1) + 1))
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            filteredItems = querySnapshot.docs
                .map((document) => Info.fromDocumentSnapshot(document))
                .toList();
            isloading = false;
          });
        } else {
          setState(() {
            isloading = false;
          });
        }
      });
    }
  }

  var selectedValue = 'type';

  void showFilterOptions() {
    final selectedValueBackup = selectedValue; // Backup the selected value
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Type'),
                    onTap: () {
                      setState(() {
                        selectedValue = 'type';
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Name'),
                    onTap: () {
                      setState(() {
                        selectedValue = 'name';
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Address'),
                    onTap: () {
                      setState(() {
                        selectedValue = 'address';
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Restore the original selected value if the dialog is dismissed
                setState(() {
                  selectedValue = selectedValueBackup;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    showFilterOptions();
                  },
                  icon:const Icon(
                    size: 18,
                    Icons.filter_alt,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Filter',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                const Text(
                  'Lawyer Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  // textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 5,
              left: 27,
              right: 31,
            ),
            child: SizedBox(
              width: 370,
              height: 40,
              child: TextField(
                autocorrect: true,
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  hintText: 'Enter the keyword',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                onChanged: (string) {
                  fetchSearchResults(string, selectedValue);
                },
              ),
            ),
          ),
          isloading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: filteredItems.isNotEmpty
                      ? ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            Info info = filteredItems[index] as Info;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LawyerDetailsPage(
                                              lawerInfo: info,
                                            )));
                              },
                              child: Column(
                                children: [
                                  const SizedBox(
                                      height: 17), // Gap between list tiles
                                  Container(
                                    width: 370,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF050125),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ExpansionTile(
                                      title: ListTile(
                                        title: Text(
                                          info.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFFC99F4A),
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle: !info.isExpanded
                                            ? Text(
                                                '${info.lawyerId}\n${info.type}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            : Text(
                                                'Advocate at ${info.location}',
                                                style: const TextStyle(
                                                  color: Color(0xFFC99F4A),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                        leading: info.profile != ''
                                            ? const Icon(
                                                Icons.person,
                                                color: Colors.blue,
                                              )
                                            : ImageIcon(
                                                NetworkImage(info.profile),
                                              ),
                                      ),
                                      onExpansionChanged: (expanded) {
                                        setState(() {
                                          info.isExpanded = expanded;
                                        });
                                      },
                                      trailing: const Icon(
                                        Icons.expand_more,
                                        color: Color(0xFFC99F4A),
                                      ),
                                      children: [
                                        Container(
                                          width: 370,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF050125),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0, bottom: 30.0),
                                            child: ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Mobile: ${info.mobileNumber}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          10), // Adding space here
                                                  Text(
                                                    'Email: ${info.email}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          10), // Adding space here
                                                  Text(
                                                    'Address: ${info.address}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No results found'),
                        ),
                )
        ],
      ),
    );
  }
}