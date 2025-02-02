import 'package:biblio/screens/login/login_screen.dart';
import 'package:biblio/screens/login/register_page.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/width.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});
  static String id = 'OnboardScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

          /// Image header
          SizedBox(
        // height: 410.sp,
        child: Image.asset(
          'assets/images/onboared_view_2.png',
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const H(h: 16),

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
              const W(w: 8),
              SvgPicture.asset(
                'assets/svg/logo.svg',
                height: 20.sp,
              ),
            ],
          ),
          const H(h: 8),

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
              ),
            ),
          ),
          const H(h: 16),

          /// Login
          CustomButton(
            padding: 16,
            text: 'تسجيل الدخول',
            onTap: () {
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          ),
          const H(h: 10),

          /// Sign up
          CustomBorderBotton(
            padding: 16,
            text: 'حساب جديد',
            onTap: () {
              Navigator.pushReplacementNamed(context, RegisterScreen.id);
            },
          ),
          // const H(h: 10),

          /// To HomePage as visitor
          // const SignAsVisitor(),
          const H(h: 34),
        ],
      ),
    );
  }
}
