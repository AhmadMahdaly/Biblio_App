import 'package:biblio/components/custom_button.dart';
import 'package:biblio/components/height.dart';
import 'package:biblio/components/width.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/login/login_screen.dart';
import 'package:biblio/screens/login/register_page.dart';
import 'package:biblio/screens/select_your_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});
  static String id = 'OnboardScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 12.sp,
        children: [
          /// Image header
          SizedBox(
            height: 410.sp,
            child: Image.asset(
              'assets/images/onboared_view.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          /// Title Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'اقرأ وبدِّل',
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const W(w: 10),
              SvgPicture.asset(
                'assets/svg/logo.svg',
                height: 20.sp,
              ),
            ],
          ),

          /// Desc text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Text(
              'هل تحب القراءة وترغب في مشاركة مكتبتك مع الآخرين؟ تطبيق Biblio يمنحك فرصة لعرض الكتب التي ترغب في تبادلها أو بيعها، واكتشاف كنوزًا جديدة في مكتبات القراء من حولك.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                height: 1.5.sp,
              ),
            ),
          ),
          const H(h: 4),

          /// Login
          CustomButton(
            padding: 16,
            text: 'تسجيل الدخول',
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),

          /// Sign up
          CustomBorderBotton(
            padding: 16,
            text: 'حساب جديد',
            onTap: () {
              Navigator.pushNamed(context, SignUpScreen.id);
            },
          ),

          /// To HomePage as visitor
          InkWell(
            onTap: () {
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
              style: TextStyle(
                color: const Color(0xFF3E5879),
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.underline,
                decorationColor: kMainColor,
                height: 1.35.sp,
              ),
            ),
          ),
          // width: MediaQuery.of(context).size.width,
        ],
      ),
    );
  }
}
