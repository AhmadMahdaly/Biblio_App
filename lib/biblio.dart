import 'package:biblio/screens/add_book_page/add_book.dart';
import 'package:biblio/screens/book_item/edit_my_book.dart';
import 'package:biblio/screens/login/login_screen.dart';
import 'package:biblio/screens/login/register_page.dart';
import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/screens/onboard/onboard_screen.dart';
import 'package:biblio/screens/splash_screen.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Biblio extends StatelessWidget {
  const Biblio({super.key});

  @override
  Widget build(BuildContext context) {
    /// ScreenUtils
    return ScreenUtilInit(
      designSize: const Size(
        390,
        844,
      ),
      minTextAdapt: true,
      child:

          /// Remove focus from any input element
          GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
        },

        /// MaterialApp
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Biblio',

          /// Localizations
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          /// Theme
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: kScaffoldBackgroundColor,
              iconTheme: IconThemeData(
                color: kMainColor,
              ),
            ),
            scaffoldBackgroundColor: kScaffoldBackgroundColor,
            textTheme: Theme.of(
              context,
            ).textTheme.apply(
                  fontFamily: 'Avenir Arabic',
                ),
          ),

          /// Routes
          routes: {
            SplashScreen.id: (context) => const SplashScreen(),
            OnboardScreen.id: (context) => const OnboardScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            RegisterScreen.id: (context) => const RegisterScreen(),
            NavigationBarApp.id: (context) => const NavigationBarApp(),
            AddBook.id: (context) => const AddBook(),
            EditBook.id: (context) => const EditBook(),
          },
          initialRoute: SplashScreen.id,
        ),
      ),
    );
  }
}
