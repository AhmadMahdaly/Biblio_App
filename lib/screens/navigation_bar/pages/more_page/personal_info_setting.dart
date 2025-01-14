import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/screens/navigation_bar/pages/add_book_page/widgets/title_form_add_book.dart';
import 'package:biblio/services/delete_user.dart';
import 'package:biblio/services/upload_user_image.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PersonalInfoSetting extends StatefulWidget {
  const PersonalInfoSetting({super.key});

  @override
  State<PersonalInfoSetting> createState() => _PersonalInfoSettingState();
}

class _PersonalInfoSettingState extends State<PersonalInfoSetting> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isInAsyncCall = false;
  bool isShowPassword = true;

  Future<void> _updateUserData() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    setState(() {
      isInAsyncCall = true;
    });
    if (user == null) {
      setState(() {
        isInAsyncCall = false;
      });
      showSnackBar(context, 'المستخدم غير موجود');
      return;
    }

    var newName = _nameController.text.trim();
    var newEmail = _emailController.text.trim();
    var newPassword = _passwordController.text.trim();

    ///
    if (newName.isEmpty || newName == null) {
      final response = await supabase
          .from('users')

          /// اسم الجدول
          .select('username')

          /// العمود المطلوب
          .eq('id', user.id)

          /// البحث باستخدام معرف المستخدم
          .single();

      /// استرجاع صف واحد فقط

      final name = response['username'] as String;
      if (name != null) {
        _nameController.text = name;

        /// عرض الاسم الحالي في TextField
      }
      newName = response['username'] as String;
    }

    ///
    if (newEmail.isEmpty || newEmail == null) {
      final response = await supabase
          .from('users')

          /// اسم الجدول
          .select('email')

          /// العمود المطلوب
          .eq('id', user.id)

          /// البحث باستخدام معرف المستخدم
          .single();

      /// استرجاع صف واحد فقط

      newEmail = response['email'] as String;
    }

    ///
    if (newPassword.isEmpty || newPassword == null) {
      final response = await supabase
          .from('users')

          /// اسم الجدول
          .select('password')

          /// العمود المطلوب
          .eq('id', user.id)

          /// البحث باستخدام معرف المستخدم
          .single();

      /// استرجاع صف واحد فقط

      newPassword = response['password'] as String;
    }

    try {
      /// تحديث الاسم في قاعدة البيانات
      final response = await supabase
          .from('users')
          .update({'username': newName}).eq('id', user.id);
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          email: newEmail,
          password: newPassword,
        ),
      );

      setState(() {
        isInAsyncCall = false;
      });
      if (response == null) {
        showSnackBar(context, 'خطأ أثناء التحديث');
      }
      showSnackBar(context, 'تم الحفظ');
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationBarApp(),
        ),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        isInAsyncCall = false;
      });

      showSnackBar(context, '/n$eهناك حدث خطأ، من فضلك راجع البيانات!');
    }
  }

  ///
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isInAsyncCall,
      opacity: 0.2,
      blur: 0.2,

      /// Spin indicator: wave
      progressIndicator: const AppIndicator(),

      child: Scaffold(
        appBar: AppBar(
          /// Title
          title: Text(
            'تعديل البيانات الشخصية',
            style: TextStyle(
              color: kMainColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              height: 1.71,
            ),
          ),

          /// Leading
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationBarApp(),
                ),
                (route) => false,
              ); // إزالة جميع الصفحات
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 22.sp,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 10.sp,
          ),
          child: ListView(
            children: [
              /// Upload user image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleFormAddBook(title: 'الصورة الشخصية'),
                  IconButton(
                    onPressed: () {
                      uploadUserPhoto(context);
                    },
                    icon: Icon(
                      Icons.upload,
                      size: 24.sp,
                      color: kMainColor,
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1.sp,
                height: 16.sp,
              ),

              /// Name
              const TitleFormAddBook(title: 'الاسم'),
              CustomTextformfield(
                controller: _nameController,
                text: _nameController.text,
              ),

              /// Email
              const TitleFormAddBook(title: 'البريد الإلكتروني'),
              CustomTextformfield(
                controller: _emailController,
                text: 'البريد الإلكتروني',
              ),

              /// Password
              const TitleFormAddBook(title: 'كلمة المرور'),
              CustomTextformfield(
                controller: _passwordController,
                // text: '*********',
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

              /// Delete Account
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.sp),
                child: const DeleteUser(),
              ),
            ],
          ),
        ),

        /// Save
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.sp),
          child: CustomButton(
            padding: 16,
            text: 'حفظ',
            onTap: _updateUserData,
          ),
        ),
      ),
    );
  }
}
