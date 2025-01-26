import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  ///
  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
    });
    final email = _emailController.text;
    if (email.isEmpty) {
      showSnackBar(context, 'يرجى إدخال البريد الإلكتروني');
      return;
    }
    try {
      await supabase.auth
          .resetPasswordForEmail(
            email,
          )
          .timeout(const Duration(seconds: 66));

      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني',
      );
    } catch (error) {
      showSnackBar(context, 'حدث خطأ أثناء إرسال الرابط. حاول مرة أخرى');

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const AppIndicator()
          : SingleChildScrollView(
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
                        'هل نسيت كلمة المرور؟',
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'من فضلك أدخل البريد الإلكتروني الخاص بحسابك',
                        style: TextStyle(
                          color: kTextShadowColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
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
                        controller: _emailController,
                        text: 'البريد الإلكتروني',
                      ),
                      const H(h: 10),

                      /// Button
                      CustomButton(
                        // isActive: false,
                        onTap: resetPassword,
                        text: 'إرسال الرمز',
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
