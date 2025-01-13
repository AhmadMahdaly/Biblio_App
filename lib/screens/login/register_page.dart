import 'package:biblio/screens/login/login_screen.dart';
import 'package:biblio/screens/select_your_location_screen.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = 'SignUpScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
// ID المستخدم لتحديده بعد التسجيل
  String? userId;
  String? userName;
  String? email;
  String? password;
  final formKey = GlobalKey<FormState>();
  bool isInAsyncCall = false;
  bool isShowPassword = true;

  ///
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Sign Up
  Future<AuthResponse> signUp(String userName) {
    return supabase.auth.signUp(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      data: {
        'name': userName,
        'password': password,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Loading progress
    return ModalProgressHUD(
      inAsyncCall: isInAsyncCall,
      opacity: 0.2,
      blur: 0.2,

      /// Spin indicator: wave
      progressIndicator: const AppIndicator(),

      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.sp),

              /// Form
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
                      controller: userNameController,
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
                      controller: emailController,
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
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                      text: 'كلمة المرور',
                      icon: IconButton(
                        onPressed: () => setState(
                          () {
                            isShowPassword = !isShowPassword;
                          },
                        ),
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

                    const H(h: 10),
                  ],
                ),
              ),
            ),
          ),
        ),

        ///
        bottomNavigationBar: Column(
          spacing: 12.sp,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Sign up Button
            CustomButton(
              text: 'إنشاء الحساب',
              padding: 16,
              onTap: () async {
                final email = emailController.text;
                final userName = userNameController.text;
                if (formKey.currentState!.validate()) {
                  setState(() {
                    isInAsyncCall = true;
                  });

                  try {
                    final response = await signUp(userName);
                    if (response.user != null) {
                      // إضافة اسم المستخدم إلى جدول "users" بعد نجاح التسجيل
                      await supabase.from('users').insert({
                        // ربط المستخدم باستخدام UID
                        'id': response.user?.id,
                        'username': userName,
                        'email': email,
                        'password': password,
                      });
                    }
                    showSnackBar(
                      context,
                      'تم التسجيل',
                    );
                    setState(() {
                      isInAsyncCall = false;
                      userId = response.user!.id;
                    });
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SelectYourLocationScreen();
                        },
                      ),
                    );
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
                    } else if (error.message == 'Password is not valid') {
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
                      'أوبس، هناك خطأ في التسجيل! ربما يكون هناك مشكلة في الإتصال.\n$e',
                    );
                  }
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
      ),
    );
  }
}
