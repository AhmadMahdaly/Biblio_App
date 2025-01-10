import 'package:biblio/components/app_indicator.dart';
import 'package:biblio/components/custom_button.dart';
import 'package:biblio/components/custom_textformfield.dart';
import 'package:biblio/components/height.dart';
import 'package:biblio/components/show_snackbar.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/login/login_screen.dart';
import 'package:biblio/screens/select_your_location_screen.dart';
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

  String? userId; // ID المستخدم لتحديده بعد التسجيل
  String? userName, email, password;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  bool isInAsyncCall = false;
  bool isShowPassword = true;

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
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                      text: 'كلمة المرور',
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
                    final response = await supabase.auth.signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        data: {'name': userName});
                    if (response.user != null) {
                      // إضافة اسم المستخدم إلى جدول "users" بعد نجاح التسجيل
                      await supabase.from('users').insert({
                        'id': response.user?.id, // ربط المستخدم باستخدام UID
                        'username': userName,
                        'email': email,
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

                    // ignore: avoid_catches_without_on_clauses
                  } catch (e) {
                    print(e.toString());
                    showSnackBar(
                      context,
                      // 'أوبس، هناك خطأ في التسجيل!',
                      e.toString(),
                    );
                    setState(() {
                      isInAsyncCall = false;
                    });
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
