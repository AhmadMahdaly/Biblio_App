import 'package:biblio/screens/login/register_page.dart';
import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/utils/components/app_regex.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final supabase = Supabase.instance.client;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// ID المستخدم لتحديده بعد التسجيل
  String? userId;

  ///
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isInAsyncCall = false;
  bool isShowPassword = true;

  ///
  Future<AuthResponse> signIn() {
    return supabase.auth.signInWithPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  ///
  Future<void> resetPassword() async {
    setState(() {
      isInAsyncCall = true;
    });
    final email = emailController.text.trim();
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
        isInAsyncCall = false;
      });
      showSnackBar(
        context,
        'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني',
      );
    } catch (error) {
      showSnackBar(context, 'حدث خطأ أثناء إرسال الرابط. حاول مرة أخرى');

      setState(() {
        isInAsyncCall = false;
      });
    }
  }

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
                      controller: emailController,
                      text: 'البريد الإلكتروني',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!AppRegex.isEmailValid(
                          emailController.text,
                        )) {
                          return 'هذا البريد الإلكتروني غير صالح';
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
                      controller: passwordController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'كلمة المرور غير صالحة';
                        }
                        return null;
                      },
                      text: 'كلمة المرور',

                      /// Check show password
                      icon: IconButton(
                        onPressed: () => setState(() {
                          isShowPassword = !isShowPassword;
                        }),
                        icon: isShowPassword
                            ? Icon(
                                Icons.visibility_off_outlined,
                                size: 24.sp,
                                color: kHeader1Color,
                              )
                            : Icon(
                                Icons.visibility_outlined,
                                size: 24.sp,
                                color: kHeader1Color,
                              ),
                      ),
                      obscureText: isShowPassword,
                    ),

                    /// Forget password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (emailController == null) {
                              showSnackBar(
                                context,
                                'قم بإدخال البريد الإلكتروني قبل الضغط على "نسيت كلمة المرور"',
                              );
                            }
                            {
                              resetPassword();
                            }

                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return const ForgetPasswordPage();
                            //     },
                            //   ),
                            // );
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
                          setState(() {
                            isInAsyncCall = true;
                          });

                          try {
                            final response = await signIn();
                            setState(() {
                              isInAsyncCall = false;
                              userId = response.user!.id;
                              Navigator.pushReplacementNamed(
                                context,
                                NavigationBarApp.id,
                              );
                            });
                          } on AuthException catch (error) {
                            setState(() {
                              isInAsyncCall = false;
                            });
                            if (error.message == 'Invalid login credentials') {
                              showSnackBar(
                                context,
                                'بيانات تسجيل الدخول غير صحيحة',
                              );
                            } else if (error.message == 'Email is not valid') {
                              showSnackBar(
                                context,
                                'البريد الإلكتروني غير صالح',
                              );
                            } else if (error.message ==
                                'Password is not valid') {
                              showSnackBar(
                                context,
                                'كلمة المرور غير صالحة',
                              );
                            } else if (error.message == 'User not found') {
                              showSnackBar(
                                context,
                                'المستخدم غير موجود',
                              );
                            } else if (error.message ==
                                'Password should be at least 6 characters') {
                              showSnackBar(
                                context,
                                'كلمة المرور ضعيفة',
                              );
                            }
                          } catch (e) {
                            setState(() {
                              isInAsyncCall = false;
                            });
                            showSnackBar(
                              context,
                              'أوبس، هناك خطأ في تسجيل الدخول! ربما يكون هناك مشكلة في الإتصال.\n$e',
                            );
                          }
                        }
                      },
                    ),

                    /// Sign Up
                    InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(context, RegisterScreen.id);
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
