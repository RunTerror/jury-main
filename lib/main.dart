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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:juridentt/authentication/general/login.dart';
import 'package:juridentt/calender/count_provider.dart';
import 'package:juridentt/chat_provider.dart';
import 'package:juridentt/client/clientsearchpage.dart';
import 'package:juridentt/internship_provider.dart';
import 'package:juridentt/navbar.dart';
import 'package:juridentt/navbar/navbar_provider.dart';
import 'package:juridentt/profile_provider.dart';
import 'package:juridentt/router.dart';
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
      const Duration(seconds: 2),
      () {
        checkFirstTime();
      },
    );
  }

  void checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('firstTime') ?? true;

    if (context.mounted) {
      if (isFirstTime) {
        await prefs.setBool('firstTime', false);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScree()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LandingScreen(userType: userType)),
        );
      }
    }
  }

  _getUserType() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    userType = sharedPreferences.getString('userType');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: themeProvider.hamcontainer),
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: Image.asset('assets/Group 33622.png')),
    );
  }
}

class OnboardingScree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          OnboardingPage(text: 'Screen 1', color: Colors.blue),
          OnboardingPage(text: 'Screen 2', color: Colors.green),
          OnboardingPage(text: 'Screen 3', color: Colors.orange),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String text;
  final Color color;

  const OnboardingPage({required this.text, required this.color});

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
        ? const LoginScreen()
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
