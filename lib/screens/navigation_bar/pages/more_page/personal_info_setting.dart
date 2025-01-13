import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/screens/navigation_bar/pages/add_book_page/widgets/title_form_add_book.dart';
import 'package:biblio/services/upload_user_image.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoSetting extends StatelessWidget {
  const PersonalInfoSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل البيانات الشخصية',
          style: TextStyle(
            color: kMainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            height: 1.71,
          ),
        ),
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
            const TitleFormAddBook(title: 'الاسم'),
            const CustomTextformfield(text: 'الاسم'),
            const TitleFormAddBook(title: 'البريد الإلكتروني'),
            const CustomTextformfield(text: 'البريد الإلكتروني'),
            const TitleFormAddBook(title: 'كلمة المرور'),
            const CustomTextformfield(
              text: '*********',
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
