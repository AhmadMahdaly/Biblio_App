import 'package:biblio/screens/select_your_location_screen.dart';
import 'package:biblio/services/sign_in_as_guest.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignAsVisitor extends StatelessWidget {
  const SignAsVisitor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        signInAsGuest();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SelectYourLocationScreen();
            },
          ),
        );
      },
      child: Text(
        'الدخول كزائر',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFF3E5879),
          fontSize: 14.sp,
          fontWeight: FontWeight.w800,
          decoration: TextDecoration.underline,
          decorationColor: kMainColor,
        ),
      ),
    );
  }
}
