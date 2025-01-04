import 'package:biblio/components/custom_button.dart';
import 'package:biblio/components/custom_textformfield.dart';
import 'package:biblio/components/height.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/login/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 16.sp,
                children: [
                  /// Header
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

                  /// Email
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
                  CustomTextformfield(
                    text: 'البريد الإلكتروني',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                  ),

                  /// Password
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    obscureText: true,
                    text: 'كلمة المرور',
                    icon: Icon(
                      Icons.remove_red_eye_rounded,
                      size: 24.sp,
                    ),
                  ),

                  /// Forget password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgetPasswordPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(
                            color: const Color(0xFF3E5879),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: kMainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const H(h: 10),

                  /// Login Button
                  CustomButton(
                    text: 'تسجيل الدخول',
                    onTap: () {
                      if (formKey.currentState!.validate()) {}
                    },
                  ),

                  /// Sign Up
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
      ),
    );
  }
}
