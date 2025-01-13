import 'package:biblio/screens/navigation_bar/pages/add_book_page/add_page.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyLibrary extends StatelessWidget {
  const EmptyLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 24.sp,
        children: [
          SvgPicture.asset('assets/svg/my_lib.svg'),
          Text(
            'مكتبتك فارغة! لم تتم إضافة كتب بعد',
            style: TextStyle(
              color: kTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1.50.sp,
            ),
          ),
          CustomButton(
            padding: 16,
            text: 'إضافة كتاب جديد',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
