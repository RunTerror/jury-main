import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandingPage1 extends StatefulWidget {
  const LandingPage1({super.key});

  @override
  State<LandingPage1> createState() => _LandingPage1State();
}

class _LandingPage1State extends State<LandingPage1> {
  late User? currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String law = '';

  @override
  void initState() {
    super.initState();
    initializeCurrentUser();
    initializeLawyerId();
  }

  void initializeCurrentUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
  }

  void initializeLawyerId() async {
    String lawyerId = await fetchLawyerId();
    setState(() {
      law = lawyerId;
    });
  }

  Future<String> fetchLawyerId() async {
    final user = FirebaseAuth.instance.currentUser;
    final userDoc =
        FirebaseFirestore.instance.collection('lawyers').doc(user!.uid);
    final userData = await userDoc.get();

    String lawyerId = userData['lawyerId'];
    return lawyerId;
  }

  Stream<List<DocumentSnapshot>> openCasesStream() {
    return FirebaseFirestore.instance
        .collection('addcase')
        .where('team', arrayContains: law)
        .where('casetype', isEqualTo: 'open')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.where((doc) => doc['team'][0] == law).toList());
  }

  Stream<List<DocumentSnapshot>> upcomingCasesStream() {
    return FirebaseFirestore.instance
        .collection('addcase')
        .where('team', arrayContains: law)
        .where('casetype', isEqualTo: 'upcoming')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.where((doc) => doc['team'][0] == law).toList());
  }

  Stream<List<DocumentSnapshot>> closedCasesStream() {
    return FirebaseFirestore.instance
        .collection('addcase')
        .where('team', arrayContains: law)
        .where('casetype', isEqualTo: 'closed')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.where((doc) => doc['team'][0] == law).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 85.h),
        child: Column(
          children: [
            Text(
              "JURIDENT",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: StreamBuilder<List<DocumentSnapshot>>(
                    stream: openCasesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<DocumentSnapshot> cases = snapshot.data!;
                        int caseCount = cases.length;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CaseDetailsPage(cases: cases),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff050125),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: MediaQuery.of(context).size.width * 0.30,
                            height: MediaQuery.of(context).size.width * 0.30,
                            child: Center(
                              child: Text(
                                '$caseCount \nOpen\ncases',
                                style: TextStyle(
                                    fontSize: 20.sp, color: const Color(0xffC99F4A)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: StreamBuilder<List<DocumentSnapshot>>(
                    stream: upcomingCasesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<DocumentSnapshot> cases = snapshot.data!;
                        int caseCount = cases.length;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CaseDetailsPage(cases: cases),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff050125),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: MediaQuery.of(context).size.width * 0.30,
                            height: MediaQuery.of(context).size.width * 0.30,
                            child: Center(
                              child: Text(
                                '$caseCount \nupcoming\ncases',
                                style: TextStyle(
                                    fontSize: 20.sp, color: const Color(0xffC99F4A)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                SizedBox(width: 10.sp),
                Expanded(
                  child: StreamBuilder<List<DocumentSnapshot>>(
                    stream: closedCasesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<DocumentSnapshot> cases = snapshot.data!;
                        int caseCount = cases.length;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CaseDetailsPage(cases: cases),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff050125),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: MediaQuery.of(context).size.width * 0.30,
                            height: MediaQuery.of(context).size.width * 0.30,
                            child: Center(
                              child: Text(
                                '$caseCount \nclosed\ncases',
                                style: TextStyle(
                                    fontSize: 20.sp, color: const Color(0xffC99F4A)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 400.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/newcase');
              },
              child: Container(
                width: 174.w,
                decoration: BoxDecoration(
                  color: const Color(0xffFFEABE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Add new case',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaseDetailsPage extends StatelessWidget {
  final List<DocumentSnapshot> cases;

  const CaseDetailsPage({super.key, required this.cases});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details'),
      ),
      body: ListView.builder(
        itemCount: cases.length,
        itemBuilder: (context, index) {
          DocumentSnapshot caseData = cases[index];
          String caseTitle = caseData['title'];
          String caseDescription = caseData['description'];

          return ListTile(
            title: Text(caseTitle),
            subtitle: Text(caseDescription),
          );
        },
      ),
    );
  }
}
