import 'package:biblio/screens/login/widgets/custom_verification_code.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({super.key});

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
                  'رمز التحقق',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'من فضلك أدخل رمز التحقق المكون من ستة أرقام',
                  style: TextStyle(
                    color: kTextShadowColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const H(h: 16),
                const CustomVerificationCode(),
                const H(h: 10),

                /// Button
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'لم يصلك الرمز؟',
                        style: TextStyle(
                          color: kHeader1Color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' إرسال مرة أخرى',
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: kMainColor,
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
