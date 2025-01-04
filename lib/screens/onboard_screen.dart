import 'package:biblio/components/custom_button.dart';
import 'package:biblio/components/height.dart';
import 'package:biblio/components/width.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/login/login_screen.dart';
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
          SizedBox(
            height: 410.sp,
            child: Image.asset(
              'assets/images/onboared_view.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
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
          CustomButton(
            text: 'تسجيل الدخول',
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
          const CustomBorderBotton(
            text: 'حساب جديد',
          ),
          Text(
            'الدخول كزائر',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF3E5879),
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
              decorationColor: kMainColor,
              height: 1.35.sp,
            ),
          ),
          // width: MediaQuery.of(context).size.width,
        ],
      ),
    );
  }
}
