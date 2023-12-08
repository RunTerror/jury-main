// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:juridentt/home.dart';
// // import 'package:juridentt/onboarding/onboarding1.dart';
// // import 'package:juridentt/router.dart';
// // import 'package:provider/provider.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'addcase/newcase_form.dart';
// // import 'addcase/provider.dart';
// // import 'client/home/home.dart';
// // import 'provider1.dart';
// // import 'firebase_options.dart';

// // import 'package:firebase_performance/firebase_performance.dart'
// //     as firebase_performance;

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
// //   firebase_performance.FirebasePerformance.instance
// //       .setPerformanceCollectionEnabled(true);
// //   runApp(
// //     MultiProvider(
// //       providers: [
// //         ChangeNotifierProvider(
// //           create: (context) => UserProvider(),
// //         ),
// //         // ChangeNotifierProvider<NewCaseFormProvider>(
// //         //   create: (context) => NewCaseFormProvider(),
// //         // ),
// // ChangeNotifierProvider<PageIndex>(
// //   create: (context) => PageIndex(),
// // ),
// //         ChangeNotifierProvider(create: (context) => ThemeProvider()),
// //         ChangeNotifierProvider(
// //           create: (context) => CaseFormState(),
// //         ),
// //         ChangeNotifierProvider(
// //           create: (context) => CaseNotesProvider(),
// //         ),
// //       ],
// //       child: const MyApp(),
// //     ),
// //   );
// // }

// // class MyApp extends StatefulWidget {
// //   const MyApp({super.key});

// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   Future<String?> getUserType() async {
// //     final sharedPreferences = await SharedPreferences.getInstance();
// //     return sharedPreferences.getString('userType');
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       onGenerateRoute: (settings) => generateRoute(settings),
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData.light().copyWith(
// //         // Set the primary color to control the notification panel color
// //         primaryColor: Colors.blue,
// //         // Replace with your desired color
// //       ),
// //       darkTheme: ThemeData.dark(),
// //       themeMode: Provider.of<ThemeProvider>(context).isDarkModeEnabled
// //           ? ThemeMode.dark
// //           : ThemeMode.light,
// //       home: StreamBuilder(
// //         stream: FirebaseAuth.instance.authStateChanges(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }
// //           if (snapshot.connectionState == ConnectionState.active) {
// //             if (snapshot.hasData) {
// //               return FutureBuilder<String?>(
// //                 future: getUserType(),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   }
// //                   final userType = snapshot.data;
// //                   if (snapshot.hasData) {
// //                     if (userType == 'lawyer') {
// //                       return const Homescreen();
// //                     } else if (userType == 'client') {
// //                       return const HomescreenClient();
// //                       // return const Navbar();
// //                     }
// //                   }
// //                   // return const Category();
// //                   return const OnboardingScreen();
// //                 },
// //               );
// //             }
// //           }
// //           // return const Category();
// //           return const OnboardingScreen();
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:juridentt/authentication/general/login.dart';
// // import 'package:juridentt/authentication/category/category.dart';
// import 'package:juridentt/calender/count_provider.dart';
// import 'package:juridentt/client/home/home.dart';
// import 'package:juridentt/home.dart';
// import 'package:juridentt/navbar/navbar_provider.dart';
// // import 'package:juridentt/onboarding/onboarding1.dart';
// import 'package:juridentt/router.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'addcase/newcase_form.dart';
// import 'addcase/provider.dart';
// import 'authentication/general/signup.dart';
// import 'provider1.dart';
// import 'firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:juridentt/models/user.dart';
// import 'package:firebase_performance/firebase_performance.dart'
//     as firebase_performance;
// // import 'package:juridentt/authentication/general/signup.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   firebase_performance.FirebasePerformance.instance
//       .setPerformanceCollectionEnabled(true);
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => CountProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => UserProvider(),
//         ),
//         ChangeNotifierProvider<PageIndex>(
//           create: (context) => PageIndex(),
//         ),
//         // ChangeNotifierProvider<NewCaseFormProvider>(
//         //   create: (context) => NewCaseFormProvider(),
//         // ),
//         ChangeNotifierProvider(create: (context) => ThemeProvider()),
//         ChangeNotifierProvider(
//           create: (context) => CaseFormState(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => CaseNotesProvider(),
//         ),
//         ChangeNotifierProvider(create: (context) => NavbarProvider())
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<String?> getUserType() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     String? usertype = sharedPreferences.getString('userType');
//     if (usertype == 'lawyer') {
//       await FirebaseFirestore.instance
//           .collection('lawyers')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .get()
//           .then((value) => {
//                 Provider.of<UserProvider>(context, listen: false).setUser(
//                   Info.fromDocumentSnapshot(value),
//                 )
//               });
//     }
//     return usertype;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         designSize: const Size(428, 926),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         builder: (context, child) {
//           return MaterialApp(
//             onGenerateRoute: (settings) => generateRoute(settings),
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData.light().copyWith(
//               // Set the primary color to control the notification panel color
//               primaryColor: Colors.blue,
//               // Replace with your desired color
//             ),
//             darkTheme: ThemeData.dark(),
//             themeMode: Provider.of<ThemeProvider>(context).isDarkModeEnabled
//                 ? ThemeMode.dark
//                 : ThemeMode.light,
//             // home: const newCases(),
//             // home: const Navbar(),
//             home: StreamBuilder(
//               stream: FirebaseAuth.instance.authStateChanges(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (snapshot.connectionState == ConnectionState.active) {
//                   if (snapshot.hasData) {
//                     return FutureBuilder<String?>(
//                       future: getUserType(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         }
//                         final userType = snapshot.data;
//                         if (snapshot.hasData) {
//                           if (userType == 'lawyer') {
//                             return const Homescreen();
//                           } else if (userType == 'client') {
//                             return const HomescreenClient();
//                             // return const Navbar();
//                           }
//                         }
//                         // return const Category();
//                         //return const SignupScreen();
//                         return const LoginScreen();
//                       },
//                     );
//                   }
//                 }
//                 // return const Category();
//                 // return const SignupScreen();
//                 return const LoginScreen();
//               },
//             ),
//           );
//         });
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:juridentt/home.dart';
// import 'package:juridentt/onboarding/onboarding1.dart';
// import 'package:juridentt/router.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'addcase/newcase_form.dart';
// import 'addcase/provider.dart';
// import 'client/home/home.dart';
// import 'provider1.dart';
// import 'firebase_options.dart';

// import 'package:firebase_performance/firebase_performance.dart'
//     as firebase_performance;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   firebase_performance.FirebasePerformance.instance
//       .setPerformanceCollectionEnabled(true);
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => UserProvider(),
//         ),
//         // ChangeNotifierProvider<NewCaseFormProvider>(
//         //   create: (context) => NewCaseFormProvider(),
//         // ),
// ChangeNotifierProvider<PageIndex>(
//   create: (context) => PageIndex(),
// ),
//         ChangeNotifierProvider(create: (context) => ThemeProvider()),
//         ChangeNotifierProvider(
//           create: (context) => CaseFormState(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => CaseNotesProvider(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<String?> getUserType() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getString('userType');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       onGenerateRoute: (settings) => generateRoute(settings),
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light().copyWith(
//         // Set the primary color to control the notification panel color
//         primaryColor: Colors.blue,
//         // Replace with your desired color
//       ),
//       darkTheme: ThemeData.dark(),
//       themeMode: Provider.of<ThemeProvider>(context).isDarkModeEnabled
//           ? ThemeMode.dark
//           : ThemeMode.light,
//       home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData) {
//               return FutureBuilder<String?>(
//                 future: getUserType(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   final userType = snapshot.data;
//                   if (snapshot.hasData) {
//                     if (userType == 'lawyer') {
//                       return const Homescreen();
//                     } else if (userType == 'client') {
//                       return const HomescreenClient();
//                       // return const Navbar();
//                     }
//                   }
//                   // return const Category();
//                   return const OnboardingScreen();
//                 },
//               );
//             }
//           }
//           // return const Category();
//           return const OnboardingScreen();
//         },
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:juridentt/authentication/general/login.dart';
import 'package:juridentt/authentication/general/signup.dart';
import 'package:juridentt/calender/count_provider.dart';
import 'package:juridentt/chat_provider.dart';
import 'package:juridentt/client/clientsearchpage.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/internship_provider.dart';
import 'package:juridentt/navbar.dart';
import 'package:juridentt/navbar/navbar_provider.dart';
import 'package:juridentt/profile_provider.dart';
import 'package:juridentt/router.dart';
import 'package:open_file/open_file.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addcase/newcase_form.dart';
import 'addcase/provider.dart';
import 'models/userprovider.dart';
import 'provider1.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juridentt/models/user.dart';
import 'package:firebase_performance/firebase_performance.dart'
    as firebase_performance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'jury',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebase_performance.FirebasePerformance.instance
      .setPerformanceCollectionEnabled(true);
  final userDetailProvider = UserDetailProvider();
  await userDetailProvider.fetchUserDetail();
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<PageIndex>(
          create: (context) => PageIndex(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
        // ChangeNotifierProvider<NewCaseFormProvider>(
        //   create: (context) => NewCaseFormProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => InternShipProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => CaseFormState(),
        ),
        ChangeNotifierProvider(
          create: (context) => CaseNotesProvider(),
        ),
        ChangeNotifierProvider(create: (context) => NavbarProvider()),
        ChangeNotifierProvider(create: (context) => PersistentTabController())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late String? islogin;

  // usertype() async {
  //   final sp = await SharedPreferences.getInstance();
  //   final user = sp.getString('userType');

  //   setState(() {
  //     islogin = user;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: ScreenUtilInit(
          designSize: const Size(428, 926),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
                onGenerateRoute: (settings) => generateRoute(settings),
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light().copyWith(
                  primaryColor: Colors.blue,
                ),
                darkTheme: ThemeData.dark(),
                themeMode: Provider.of<ThemeProvider>(context).isDarkModeEnabled
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: const SplashScreen());
          }),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userType;

  @override
  void initState() {
    super.initState();
    _getUserType();
    Timer(
      const Duration(milliseconds: 1500),
      () {
        checkFirstTime();
      },
    );
  }

  void checkFirstTime() async {
    final sp = await SharedPreferences.getInstance();
    final result = sp.getBool('shown');
    print(result);
    if (result == null) {
      navigateOnboarding(context);
      await sp.setBool('shown', true);
    } else {
      navigateLanding(context);
    }
  }

  navigateOnboarding(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScree()),
    );
  }

  navigateLanding(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LandingScreen(userType: userType)),
    );
  }

  _getUserType() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    userType = sharedPreferences.getString('userType');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: themeProvider.hamcontainer,
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: themeProvider.hamcontainer),
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Image.asset('assets/Group 33622.png')),
            Positioned(
                top: 0, left: 80, child: Image.asset('assets/Ellipse 706.png')),
            Positioned(
                top: h / 3.2,
                left: 30,
                child: Image.asset('assets/JURIDENT.png')),
            Positioned(
                bottom: 0,
                left: 200,
                child: Image.asset('assets/Ellipse 705.png')),
          ],
        ));
  }
}

// splash screen

class OnboardingScree extends StatefulWidget {
  const OnboardingScree({super.key});

  @override
  State<OnboardingScree> createState() => _OnboardingScreeState();
}

class _OnboardingScreeState extends State<OnboardingScree> {
  static final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_handlePageChange);
  }

  void _handlePageChange() {
    setState(() {
      _currentPage = _pageController.page!.round();
    });
  }

  final function = () {
    _pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  };

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            controller: _pageController,
            children: [
              OnboardingPage1(
                function: function,
              ),
              OnboardingPage2(
                function: function,
              ),
              const OnboardingPage3(),
            ],
          ),
          _currentPage == 2
              ? Container()
              : Positioned(
                  top: 50,
                  right: 10,
                  child: InkWell(
                      onTap: () {
                        _pageController.jumpToPage(2);
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
          Positioned(
            bottom: h / 7,
            left: (w / 2) - 30,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: DotsIndicator(
                dotsCount: 3,
                position: _currentPage,
                decorator: const DotsDecorator(
                  color: Colors.white, // Inactive dot color
                  activeColor: Colors.blue, // Active dot color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget nextButton(
  VoidCallback function,
  double h,
  double w,
) {
  return InkWell(
    onTap: function,
    child: Container(
      height: h / 20,
      width: w / 1.3,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text('Next'),
      alignment: Alignment.center,
    ),
  );
}

class OnboardingPage extends StatelessWidget {
  final String text;
  final Color color;

  const OnboardingPage({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  final VoidCallback function;
  const OnboardingPage1({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: themeProvider.hamcontainer,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
                bottom: 40,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      // height: double.infinity,
                      width: w,
                      child: Image.asset(
                          'assets/man turned around while working at the computer.png'),
                    ),
                    Text(
                      'Stay Organized',
                      style: TextStyle(fontSize: 40, color: Constants.yellow),
                    ),
                    const Gap(20),
                    const Text(
                      'Ensure that your schedule is',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Text('accurate by entering new',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    Text('appointments or events into',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    Text('our digital calender',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    const Gap(100),
                    nextButton(function, h, w)
                  ],
                )),
            Positioned(
                right: 0, top: 100, child: Image.asset('assets/Layer_3.png')),
          ],
        ));
  }
}

class OnboardingPage2 extends StatelessWidget {
  final VoidCallback function;
  const OnboardingPage2({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: themeProvider.hamcontainer,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
                bottom: 40,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      // height: double.infinity,
                      width: w,
                      child: Image.asset(
                          'assets/businesswoman leaning on big clock with arms crossed.png'),
                    ),
                    Text(
                      'Never Late',
                      style: TextStyle(fontSize: 40, color: Constants.yellow),
                    ),
                    Gap(20),
                    Text(
                      'Our alarm system integrated',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text('within the app will notify you of',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    Text('any upcoming events',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    const Gap(100),
                    nextButton(
                      function,
                      h,
                      w,
                    )
                  ],
                )),
            Positioned(
                left: 0,
                top: 100,
                child: Image.asset('assets/Layer_3 (1).png')),
          ],
        ));
  }
}

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: themeProvider.hamcontainer,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(bottom: 50),
              child:
                  Image.asset('assets/target with dart arrow in bullseye.png'),
            ),
            Positioned(
                bottom: 40,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 70),
                      // height: double.infinity,
                      width: w,
                      child: Image.asset(
                          'assets/old businessman in classical suit and glasses showing v sign.png'),
                    ),
                    Text(
                      'Everything in one place',
                      style: TextStyle(fontSize: 32, color: Constants.yellow),
                    ),
                    const Gap(20),
                    const Text(
                      'All your personal notes to',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Text('any case you\'d prefer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    const Gap(100),
                    nextButton(() {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return LawyerClientLogin();
                        },
                      ));
                    }, h, w)
                  ],
                )),
            Positioned(
                right: 0, top: 100, child: Image.asset('assets/Layer_3.png')),
          ],
        ));
  }
}

class LandingScreen extends StatefulWidget {
  final String? userType;
  const LandingScreen({super.key, required this.userType});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    _checkUserType();
    super.initState();
  }

  void _checkUserType() async {
    if (widget.userType == 'lawyer') {
      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) => {
                Provider.of<UserProvider>(context, listen: false).setUser(
                  Info.fromDocumentSnapshot(value),
                )
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.userType == null
        ? const LawyerClientLogin()
        : widget.userType == 'lawyer'
            ? const PersistentNavbar()
            : const HomePage();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class LawyerClientLogin extends StatefulWidget {
  const LawyerClientLogin({super.key});

  @override
  State<LawyerClientLogin> createState() => _LawyerClientLoginState();
}

class _LawyerClientLoginState extends State<LawyerClientLogin> {
  String user = 'lawyer';

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: themeProvider.hamcontainer),
        child: Stack(
          children: [
            Positioned(
                bottom: 100, child: Image.asset('assets/Layer_3 (1).png')),
            Positioned(
              bottom: 10,
              child: Column(
                children: [
                  Image.asset(
                      'assets/old businessman showing v sign and holding hand on hip.png'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    width: w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to Jurident!',
                          style: TextStyle(
                              fontSize: 35,
                              color: Constants.yellow,
                              fontWeight: FontWeight.w600),
                        ),
                        const Gap(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customButton(w, h, 'Lawyer', () {
                              user = 'lawyer';
                              print(user);
                              setState(() {});
                            }, user),
                            const Spacer(),
                            customButton2(w, h, 'Client', () {
                              user = 'client';
                              print(user);
                              setState(() {});
                            }, user)
                          ],
                        ),
                        const Gap(15),
                        customLoginSignup(w, h, 'Login', () {
                          Navigator.pushNamed(context, '/login',
                              arguments: {'usertype': user});
                        }, Colors.blue),
                        const Gap(15),
                        customLoginSignup(w, h, 'Signup', () {
                          Navigator.pushNamed(context, '/signup',
                              arguments: {'usertype': user});
                        }, Colors.white)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(
      double w, double h, String text, VoidCallback function, String user) {
    return InkWell(
      onTap: function,
      child: Container(
        width: w / 2.3,
        height: h / 15,
        decoration: BoxDecoration(
            color: user == 'lawyer' ? Constants.yellow : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        alignment: Alignment.center,
        child: Text(
          text,
        ),
      ),
    );
  }

  Widget customButton2(
      double w, double h, String text, VoidCallback function, String user) {
    return InkWell(
      onTap: function,
      child: Container(
        width: w / 2.3,
        height: h / 15,
        decoration: BoxDecoration(
            color: user == 'client' ? Constants.yellow : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        alignment: Alignment.center,
        child: Text(
          text,
        ),
      ),
    );
  }

  Widget customLoginSignup(
      double w, double h, String text, VoidCallback function, Color color) {
    return InkWell(
      onTap: function,
      child: Container(
        width: w,
        height: h / 15,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
          text,
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
