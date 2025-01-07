import 'package:biblio/screens/navigation_bar/pages/home_page_screen.dart';
import 'package:biblio/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OneTimeOnboard extends StatefulWidget {
  const OneTimeOnboard({super.key});

  @override
  State<OneTimeOnboard> createState() => _OneTimeOnboardState();
}

class _OneTimeOnboardState extends State<OneTimeOnboard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkOnboarding(),
      builder: (context, snapshot) {
        if (snapshot.data != true) {
          return const OnboardScreen();
        } else {
          return const HomePage();
        }
      },
    );
  }

  Future<bool> _checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    if (!hasSeenOnboarding) {
      await prefs.setBool('hasSeenOnboarding', true);
    }
    return hasSeenOnboarding;
  }
}
