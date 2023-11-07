import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late bool _isDarkModeEnabled;

  final String _lightBackgroundImage = 'assets/background.png';
  final String _darkBackgroundImage = 'assets/background_dark.png';

  Color get nextButtonColor =>
      _isDarkModeEnabled ? const Color(0xFFC99F4A) : const Color(0xFF050125);
  Color get appbarcolor=>
      _isDarkModeEnabled ?  const Color(0xFF40A2B6):  const Color(0xFFFFFFFF) ;
  Color get skipButtonColor =>
      _isDarkModeEnabled ? Colors.white : const Color(0xFF050125);
       Color get navinactiveColor =>
      _isDarkModeEnabled ? Colors.black : Colors.white;

       Color get ham =>
      _isDarkModeEnabled ? Colors.black : Colors.black;

      

      

  Color get notesbackground =>
      _isDarkModeEnabled ? const Color(0xFF050125) : Colors.white;

  Color get editext =>
      _isDarkModeEnabled ? Colors.white : const Color(0xFF050125);
  Color get logintext => _isDarkModeEnabled ? Colors.black : Colors.black;

  Color get skipButtonTextColor =>
      _isDarkModeEnabled ? const Color(0xFFC99F4A) : Colors.white;

  Color get scaffoldcolor => _isDarkModeEnabled ? Colors.black : Colors.white;

  Color get darkopp =>
      _isDarkModeEnabled ? const Color(0xFFC99F4A) : Colors.black;

  Color get bordercolor =>
      _isDarkModeEnabled ? const Color(0xFFC99F4A) : const Color(0xFF050125);

  Color get casescaffold =>
      _isDarkModeEnabled ? const Color(0xFF08023A) : Colors.white;

  Color get casestext =>
      _isDarkModeEnabled ? Colors.white : const Color(0xFF08023A);
  Color get hamtext =>
      _isDarkModeEnabled ? Colors.white : const Color(0xFFC99F4A);
       Color get faqapp =>
      _isDarkModeEnabled ? Colors.black : const Color(0xFFC99F4A);
             Color get newsbar =>
      _isDarkModeEnabled ?    const Color(0xFF40A2B6) : Colors.white;

  Color get detailpagebutton =>
      _isDarkModeEnabled ? const Color(0xFFC99F4A) : const Color(0xFF08023A);

  Color get hamcontainer =>
      _isDarkModeEnabled ? Colors.white : const Color.fromRGBO(5, 1, 37, 1);

  Color get opphamcontainer =>
      _isDarkModeEnabled ? const Color.fromRGBO(5, 1, 37, 1) : Colors.white;

  Color get darkModeButtonColor => _isDarkModeEnabled
      ? const Color.fromRGBO(201, 159, 74, 1)
      : const Color(0xFF08023A);

  Color get toggleColor => _isDarkModeEnabled
      ? const Color.fromRGBO(49, 80, 127, 1)
      : const Color.fromRGBO(49, 80, 127, 1);
  Color get lightNextButtonColor => const Color(0xFF050125);
  Color get lightSkipButtonColor => const Color(0xFF050125);
  Color get lightNotesBackground => Colors.white;
  Color get lightEditText => const Color(0xFF050125);
  Color get lightSkipButtonTextColor => Colors.white;
  Color get lightScaffoldColor => Colors.white;
  Color get lightDarkOpp => Colors.black;
  Color get lightBorderColor => const Color(0xFF050125);
  Color get lightCaseScaffold => Colors.white;
  Color get lightCasesText => const Color(0xFF08023A);
  Color get lightHamText => const Color(0xFFC99F4A);
  Color get lightDetailPageButton => const Color(0xFF08023A);
  Color get lightHamContainer => const Color.fromRGBO(5, 1, 37, 1);
  Color get lightOppHamContainer => Colors.white;
  Color get lightDarkModeButtonColor => const Color(0xFF08023A);
  Color get lightToggleColor => const Color.fromRGBO(49, 80, 127, 1);

  String get backgroundImage =>
      _isDarkModeEnabled ? _darkBackgroundImage : _lightBackgroundImage;

  List<Color> get gradientColors => _isDarkModeEnabled
      ? [
          const Color(0xFF40A2B6),
          const Color(0xFF050125),
          // const Color(0xFF40A2B6)
        ] // Dark mode gradient colors
      : [
          const Color(0xFFFFFFFF),
          const Color(0xFFFFFFFF)
        ]; // Light mode gradient colors
  final List<double> gradientStops = [0.2, 1.0];

  Gradient get scaffoldGradient => LinearGradient(
        colors: gradientColors,
        stops: gradientStops,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  final List<double> scrolgradientStops = [-1, 1.0];
  Gradient get scaffoldGradientscrol => LinearGradient(
        colors: gradientColors,
        stops: scrolgradientStops,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  Color get dotbuttonColor =>
      _isDarkModeEnabled ? const Color(0xFFC99F4A) : const Color(0xFF050125);

  ThemeProvider() {
    // _isDarkModeEnabled =
    //     SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
    _isDarkModeEnabled =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
  }

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  void toggleTheme() {
    _isDarkModeEnabled = !_isDarkModeEnabled;
    notifyListeners();
  }

  ThemeData get themeData {
    return _isDarkModeEnabled ? ThemeData.dark() : ThemeData.light();
  }
}

class CaseNotesProvider extends ChangeNotifier {
  String _casenotes = '';

  String get casenotes => _casenotes;

  set casenotes(String value) {
    _casenotes = value;
    notifyListeners();
  }
}

class PageIndex extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void incrementIndex() {
    _index++;
    notifyListeners();
  }

  void setPageIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}
