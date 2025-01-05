import 'package:biblio/components/custom_button.dart';
import 'package:biblio/components/custom_textformfield.dart';
import 'package:biblio/components/height.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final formKey = GlobalKey<FormState>();
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
                spacing: 10.sp,
                children: [
                  /// Header
                  const H(h: 100),
                  SvgPicture.asset(
                    'assets/svg/logo.svg',
                    colorFilter: const ColorFilter.mode(
                      kMainColor,
                      BlendMode.srcIn,
                    ),
                    width: 115.sp,
                  ),
                  Text(
                    'تغيير كلمة المرور',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'من فضلك أدخل كلمة المرور الجديدة',
                    style: TextStyle(
                      color: kTextShadowColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const H(h: 16),

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

                  /// Password
                  Row(
                    children: [
                      Text(
                        'تأكيد كلمة المرور',
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

                  const H(h: 16),

                  /// Login Button
                  CustomButton(
                    text: 'حفظ كلمة المرور',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                      }
                    },
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
