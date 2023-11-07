import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:provider/provider.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final pageIndex = Provider.of<PageIndex>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final backgroundImage = themeProvider.backgroundImage;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        themeProvider.isDarkModeEnabled
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        themeProvider.toggleTheme();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeProvider.skipButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/category');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'skip',
                          style: TextStyle(
                            color: themeProvider.skipButtonTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Image.asset('assets/onboarding3.png'),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Everything in one place',
                  style: TextStyle(fontSize: 36),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Add your personal notes to\n        any case you'd prefer.",
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(
                  height: 42,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildDot(pageIndex.index == 0, themeProvider.dotbuttonColor,
                        Colors.white),
                    buildDot(pageIndex.index == 1, themeProvider.dotbuttonColor,
                        Colors.white),
                    buildDot(pageIndex.index == 2, themeProvider.dotbuttonColor,
                        Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 56,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.nextButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/category');
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(157, 24.5, 158, 24.5),
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(bool isActive, Color activeColor, Color inactiveColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: isActive ? 24 : 10,
      height: 7,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        shape: isActive ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: isActive ? BorderRadius.circular(20) : null,
      ),
    );
  }
}
