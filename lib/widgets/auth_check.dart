import 'package:biblio/components/app_indicator.dart';
import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/screens/onboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // مؤشر تحميل أثناء التحقق
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppIndicator();
          // إذا كان المستخدم مسجل الدخول
        } else if (snapshot.hasData) {
          return const NavigationBarApp();
          // إذا لم يكن مسجل الدخول
        } else {
          return const OnboardScreen();
        }
      },
    );
  }
}

// class AuthCheck extends StatelessWidget {
//   const AuthCheck({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // التحقق من حالة المستخدم
//     final user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       // المستخدم مسجل الدخول
//       return const NavigationBarApp();
//     } else {
//       // المستخدم غير مسجل الدخول
//       return const OnboardScreen();
//     }
//   }
// }
