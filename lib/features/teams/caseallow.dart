import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';

class CaseDetailsPage extends StatefulWidget {
  final String casid;

  const CaseDetailsPage({Key? key, required this.casid}) : super(key: key);

  @override
  State<CaseDetailsPage> createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  List<Map<String, dynamic>> openCasesLists = [];

  @override
  void initState() {
    super.initState();
    fetchOpenCases();
  }

  Future<void> fetchOpenCases() async {
    //print('in funtion');
    final trace = FirebasePerformance.instance.newTrace('openCasesListTrace');
    await trace.start();

    FirebaseFirestore.instance
        .collection('open')
        .where('caseNo', isEqualTo: widget.casid)
        .get()
        .then((querySnapshot) {
      List<Map<String, dynamic>> openCases =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        openCasesLists = openCases;
      });
    });

    await trace.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.casid),
            if (openCasesLists.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: openCasesLists.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(openCasesLists[index]['caseNo']),
                    subtitle: Text(openCasesLists[index]['casenotes']),
                  );
                },
              ),
            if (openCasesLists.isEmpty)
              const Text('No open cases found for the provided ID.'),
          ],
        ),
      ),
    );
  }
}
