import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/screens/navigation_bar/pages/add_book_page/widgets/add_book_image.dart';
import 'package:biblio/screens/navigation_bar/pages/add_book_page/widgets/title_form_add_book.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});
  static String id = 'AddPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, NavigationBarApp.id),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          'إضافة كتاب جديد',
          style: TextStyle(
            color: kMainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: ListView(
          children: [
            Text(
              'من فضلك اضف صورة أو أكثر الكتاب',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: kTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const H(h: 10),
            Row(
              spacing: 12.sp,
              children: const [
                AddBookImages(),
                AddBookImages(),
                AddBookImages(),
              ],
            ),
            const TitleFormAddBook(title: 'اسم الكتاب'),
            const CustomTextformfield(text: 'مثال: بين القصرين'),
            const TitleFormAddBook(title: 'اسم الكاتب'),
            const CustomTextformfield(text: 'مثال: نجيب محفوظ'),
            const TitleFormAddBook(title: 'فئة الكتاب'),
            const CustomTextformfield(text: ''),
            const TitleFormAddBook(title: 'نبذة عن الكتاب'),
            const CustomTextformfield(
              text: '',
              contentPadding: 32,
            ),
            const TitleFormAddBook(title: 'حالة الكتاب'),
            const CustomTextformfield(text: ''),
            const TitleFormAddBook(title: 'نوع العرض'),
            const CustomTextformfield(text: ''),
            const H(h: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.sp),
        child: const CustomButton(text: 'إضافة الكتاب'),
      ),
    );
  }
}
