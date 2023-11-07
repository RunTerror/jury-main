import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
                        pageIndex.setPageIndex(3);
                        Navigator.pushNamed(context, '/third');
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
                const SizedBox(height: 70),
                Image.asset('assets/onboarding1.png'),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Stay Organised',
                  style: TextStyle(fontSize: 36),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  'Ensure that your schedule is accurate  by \nentering new appointments or events into\nour digital calendar',
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
                    pageIndex.incrementIndex();
                    Navigator.pushNamed(context, '/second');
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(157, 24.5, 158, 24.5),
                    child: Text('next'),
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
