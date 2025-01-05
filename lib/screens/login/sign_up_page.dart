import 'package:biblio/components/custom_button.dart';
import 'package:biblio/components/custom_textformfield.dart';
import 'package:biblio/components/height.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/login/login_screen.dart';
import 'package:biblio/screens/select_your_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? name;
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
                spacing: 12.sp,
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
                    'إنشاء حساب جديد',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const H(h: 16),

                  /// Name
                  Row(
                    children: [
                      Text(
                        'الاسم',
                        style: TextStyle(
                          color: kHeader1Color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  CustomTextformfield(
                    text: 'الاسم',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                  ),

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
                    keyboardType: TextInputType.emailAddress,
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

                  const H(h: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        spacing: 12.sp,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Sign up Button
          CustomButton(
            text: 'إنشاء الحساب',
            padding: 16,
            onTap: () {
              if (formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SelectYourLocationScreen();
                    },
                  ),
                );
              }
            },
          ),

          /// Login
          InkWell(
            onTap: () {
              Navigator.popAndPushNamed(context, LoginScreen.id);
            },
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'لديك حساب بالفعل؟ ',
                    style: TextStyle(
                      color: kHeader1Color,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: 'تسجيل الدخول',
                    style: TextStyle(
                      color: const Color(0xFF3E5879),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const H(h: 16),
        ],
      ),
    );
  }
}
