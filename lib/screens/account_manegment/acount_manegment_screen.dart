import 'package:biblio/screens/more_page/personal_info_setting.dart';
import 'package:biblio/screens/more_page/widgets/category_for_more.dart';
import 'package:biblio/screens/select_your_location_screen.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcountManegmentScreen extends StatelessWidget {
  const AcountManegmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          'إدارة الحساب',
          style: TextStyle(
            color: kTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.sp,
          ),
        ),
      ),
      body: Column(
        spacing: 12.sp,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryForMore(
            text: 'تعديل البيانات الشخصية',
            icon: Icons.mode_edit_outline_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const PersonalInfoSetting();
                  },
                ),
              );
            },
          ),
          CategoryForMore(
            text: 'تغيير الموقع الجغرافي للمشاركة',
            icon: Icons.mode_edit_outline_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SelectYourLocationScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
