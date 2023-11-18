import 'package:flutter/material.dart';
import 'package:juridentt/Contact/chat_page.dart';
import 'package:juridentt/addcase/cases.dart';
import 'package:juridentt/addcase/files.dart';
import 'package:juridentt/addcase/landing_page1.dart';
import 'package:juridentt/addcase/newcase_form.dart';
import 'package:juridentt/authentication/category/category.dart';
import 'package:juridentt/authentication/client/phone/phone_number_input.dart';
import 'package:juridentt/authentication/client/signup/signup.dart';
import 'package:juridentt/authentication/client/signup/signup_otp.dart';
import 'package:juridentt/authentication/forget_password/forgetpassword.dart';
import 'package:juridentt/calender/calendar.dart';
import 'package:juridentt/features/teams/sharedcases.dart';
import 'package:juridentt/hamburgerMenu/contacUs.dart';
import 'package:juridentt/hamburgerMenu/editprofile.dart';
// import 'package:juridentt/home.dart';
import 'package:juridentt/onboarding/onboarding1.dart';
import 'package:juridentt/onboarding/onboarding2.dart';
import 'package:juridentt/onboarding/onboarding3.dart';
import 'authentication/client/login/login.dart';
import 'authentication/client/login/login_otp.dart';
import 'authentication/lawyer/login/login.dart';
import 'authentication/lawyer/login/login_otp.dart';
import 'authentication/lawyer/phone/phone_number_input.dart';
import 'authentication/lawyer/signup/signup.dart';
import 'authentication/lawyer/signup/signup_otp.dart';
import 'hamburgerMenu/about_us.dart';
import 'hamburgerMenu/faq.dart';
import 'hamburgerMenu/feedback.dart';
import 'hamburgerMenu/hamburger_icon.dart';
import 'hamburgerMenu/terms.dart';
import 'package:juridentt/authentication/general/login.dart' as login;
import 'package:juridentt/authentication/general/signup.dart' as signup;
// import 'package:juridentt/client/clientsearchpage.dart' as clienthomepage;
import 'package:juridentt/client/clientsearchpage.dart';

import 'navbar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/first':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OnboardingScreen(),
      );

    case '/second':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OnboardingScreen2(),
      );

    case '/third':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OnboardingScreen3(),
      );

    case '/category':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Category(),
      );

    case '/signup':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const signup.SignupScreen(),
      );

    case '/login':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const login.LoginScreen(),
      );

    case '/forgetpassword':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgetPassword(),
      );

    case '/lawyerlogin':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );

    case '/lawyersignup':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );

    case '/lawyerloginotp':
      final arguments = routeSettings.arguments as Map<String, dynamic>?;

      if (arguments != null &&
          arguments.containsKey('useremail') &&
          arguments.containsKey('userpassword')) {
        final useremail = arguments['useremail'] as String;
        final userpassword = arguments['userpassword'] as String;

        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => LoginOtp(
            useremail: useremail,
            userpassword: userpassword,
          ),
        );
      } else {
        return MaterialPageRoute(
          builder: (context) =>
              const LoginScreen(), // Replace ErrorPage with your desired error page
        );
      }

    case '/lawyerhomescreen':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PersistentNavbar(),
      );

    case '/clientlogin':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreenClient(),
      );

    case '/clientsignup':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreenClient(),
      );

    case '/clientloginotp':
      final arguments = routeSettings.arguments as Map<String, dynamic>?;

      if (arguments != null &&
          arguments.containsKey('useremail') &&
          arguments.containsKey('userpassword')) {
        final useremail = arguments['useremail'] as String;
        final userpassword = arguments['userpassword'] as String;

        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => LoginOtpClient(
            useremail: useremail,
            userpassword: userpassword,
          ),
        );
      } else {
        return MaterialPageRoute(
          builder: (context) =>
              const LoginScreenClient(), // Replace ErrorPage with your desired error page
        );
      }

    case '/lawyersignupotp':
      final arguments = routeSettings.arguments as Map<String, dynamic>?;

      if (arguments != null &&
          arguments.containsKey('email') &&
          arguments.containsKey('password') &&
          arguments.containsKey('mobilenumber') &&
          arguments.containsKey('username')) {
        final email = arguments['email'] as String;
        final password = arguments['password'] as String;
        final mobileNumber = arguments['mobilenumber'] as String;
        final username = arguments['username'] as String;

        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SignUpOtp(
            email: email,
            password: password,
            mobileNumber: mobileNumber,
            username: username,
          ),
        );
      } else {
        // print('error in signup otp route, arguments are not passed properly');
        return MaterialPageRoute(
          builder: (context) =>
              const SignupScreen(), // Replace ErrorPage with your desired error page
        );
      }

    case '/clientsignupotp':
      final arguments = routeSettings.arguments as Map<String, dynamic>?;

      if (arguments != null &&
          arguments.containsKey('email') &&
          arguments.containsKey('password') &&
          arguments.containsKey('mobilenumber') &&
          arguments.containsKey('username')) {
        final email = arguments['email'] as String;
        final password = arguments['password'] as String;
        final mobilenumber = arguments['mobilenumber'] as String;
        final username = arguments['username'] as String;

        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SignUpOtpClient(
            email: email,
            password: password,
            mobilenumber: mobilenumber,
            username: username,
          ),
        );
      } else {
        // print('error in signup otp route, arguments are not passed properly');
        return MaterialPageRoute(
          builder: (context) =>
              const SignupScreenClient(), // Replace ErrorPage with your desired error page
        );
      }

    case '/homescreen':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PersistentNavbar(),
      );

    case '/addcase':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LandingPage1(),
      );

    case '/newcase':
      return MaterialPageRoute(
        settings: routeSettings,
        // builder: (_) => const newcase_form(),
        builder: (_) => newcase_form(),
      );

    case '/viewcase':
      return MaterialPageRoute(
        settings: routeSettings,
        // builder: (_) => const newcase_form(),
        builder: (_) => const CasePage(),
      );

    case '/filedownload':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Downloadfiles(),
      );

    case '/lawyerphonenumberinput':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PhoneNumberInput(),
      );

    case '/clientphonenumberinput':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PhoneNumberInputClient(),
      );

    case '/sharedcases':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SharedCasesPage(),
      );

    case HamburgerIcon.routename:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HamburgerIcon(),
      );

    case TermsAndConditions.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TermsAndConditions(),
      );

    case '/contactus':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ContactUs(),
      );

    case EditProfile.routename:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditProfile(),
      );

    case '/Aboutus':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AboutUsScreen(),
      );

    case FeedbackPage.routename:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FeedbackPage(),
      );

    case FAQ.routename:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FAQ(),
      );

    case '/calender':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Calendar(),
      );

    // case 'clientsearchpage':
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const clienthomepage.HomePage(),
    //   );

    case 'clientsearchpage':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );

     case 'chat page':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChatPage(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const SafeArea(
          child: Scaffold(
            body: Center(
              child: Text(
                'wrong page',
              ),
            ),
          ),
        ),
      );
  }
}
