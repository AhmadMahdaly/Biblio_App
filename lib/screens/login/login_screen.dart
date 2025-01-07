import 'package:biblio/components/custom_button.dart';
import 'package:biblio/components/custom_textformfield.dart';
import 'package:biblio/components/height.dart';
import 'package:biblio/components/show_snackbar.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/navigation_bar/pages/home_page_screen.dart';
import 'package:biblio/widgets/login/forget_password_screen.dart';
import 'package:biblio/screens/login/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  bool isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    /// Loading progress
    return ModalProgressHUD(
      inAsyncCall: isInAsyncCall,
      opacity: 0.2,
      blur: 0.2,

      /// Spin indicator: wave
      progressIndicator: const Center(
        child: SpinKitWave(
          color: kMainColor,
        ),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.sp),

              /// Form
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
                      onChanged: (data) {
                        email = data;
                      },
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
                      onChanged: (data) {
                        password = data;
                      },
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
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isInAsyncCall = true;
                          setState(() {});
                          try {
                            // final UserCredential userCredential =
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email!,
                              password: password!,
                            );
                            // showSnackBar(context, 'تم التسجيل');

                            await Navigator.pushNamed(context, HomePage.id);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(
                                context,
                                'المستخدم غير موجود. يرجى التسجيل.',
                              );
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(
                                context,
                                'يوجد مشكلة في البريد الإلكتروني أو كلمة المرور.',
                              );
                            }
                            // ignore: avoid_catches_without_on_clauses
                          } catch (e) {
                            showSnackBar(
                              context,
                              e.toString(),
                            );
                          }
                          isInAsyncCall = false;
                          setState(() {});
                        }
                      },
                    ),

                    /// Sign Up
                    InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(context, SignUpScreen.id);
                      },
                      child: Text.rich(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
