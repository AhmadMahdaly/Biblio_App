import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/home_page_screen.dart';
import 'package:biblio/screens/login/login_screen.dart';
import 'package:biblio/screens/onboard_screen.dart';
import 'package:biblio/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Biblio extends StatelessWidget {
  const Biblio({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        390,
        844,
      ),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kScaffoldBackgroundColor,
          textTheme: Theme.of(
            context,
          ).textTheme.apply(
                fontFamily: 'Avenir Arabic',
              ),
        ),
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          OnboardScreen.id: (context) => const OnboardScreen(),
          HomePage.id: (context) => const HomePage(),
          LoginScreen.id: (context) => const LoginScreen(),
        },
        initialRoute: SplashScreen.id,
      ),
    );
  }
}
