import 'package:flutter/material.dart';
import 'package:juridentt/client/lawyerinfo.dart';

class LawyerDetailsPage extends StatelessWidget {
  final Info lawerInfo;
  const LawyerDetailsPage({super.key, required this.lawerInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: lawerInfo.profile != ''
              ? AssetImage(lawerInfo.profile)
              : AssetImage('assets/images/lawyer1.jpeg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Container(
          // height: MediaQuery.of(context).size.height / 2,
          height: 475,
          width: 428,
          decoration: BoxDecoration(
            color: Color(0xFF050125),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(33.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        lawerInfo.name,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFC99F4A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Lawyer ID:  ${lawerInfo.lawyerId}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Type:   ${lawerInfo.type}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    Text(
                      'Phone:   ${lawerInfo.mobileNumber}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Email:   ${lawerInfo.email}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Office Adress:   ${lawerInfo.address}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 46,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 10.0),
                          primary: Color(0xFFC99F4A),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Hire Me'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
