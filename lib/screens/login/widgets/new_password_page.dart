import 'package:biblio/screens/login/login_screen.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool isShowPassword = true;
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
                    controller: _controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    obscureText: isShowPassword,
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
                      if (value != _controller.text) {
                        return 'كلمة المرور غير مطابقة';
                      }
                      return null;
                    },
                    obscureText: isShowPassword,
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
                  ),

                  const H(h: 16),

                  /// Login Button
                  CustomButton(
                    text: 'حفظ كلمة المرور',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final password = _controller.text;
                          await supabase.auth.updateUser(
                            UserAttributes(
                              password: password,
                            ),
                          );
                          await Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.id,
                            (route) => false,
                          );
                        } on AuthException catch (authError) {
                          showSnackBar(context, authError.message);
                        } catch (e) {
                          showSnackBar(context, e.toString());
                        }
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
