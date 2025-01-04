import 'package:biblio/components/custom_button.dart';
import 'package:biblio/components/custom_textformfield.dart';
import 'package:biblio/components/height.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String id = 'LoginScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              spacing: 16.sp,
              children: [
                const H(h: 90),
                SvgPicture.asset(
                  'assets/svg/logo.svg',
                  colorFilter: const ColorFilter.mode(
                    kMainColor,
                    BlendMode.srcIn,
                  ),
                  width: 115.sp,
                ),
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const H(h: 16),
                Row(
                  children: [
                    Text(
                      'البريد الإلكتروني',
                      style: TextStyle(
                        color: kHeader1Color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const CustomTextformfield(
                  text: 'البريد الإلكتروني',
                ),
                Row(
                  children: [
                    Text(
                      'كلمة المرور',
                      style: TextStyle(
                        color: kHeader1Color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                CustomTextformfield(
                  text: 'كلمة المرور',
                  icon: Icon(
                    Icons.remove_red_eye_rounded,
                    size: 24.sp,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        color: const Color(0xFF3E5879),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: kMainColor,
                      ),
                    ),
                  ],
                ),
                const H(h: 16),
                const CustomButton(
                  isActive: false,
                  text: 'تسجيل الدخول',
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'ليس لديك حساب؟ ',
                        style: TextStyle(
                          color: kHeader1Color,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'أنشىء حسابك الآن',
                        style: TextStyle(
                          color: const Color(0xFF3E5879),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
