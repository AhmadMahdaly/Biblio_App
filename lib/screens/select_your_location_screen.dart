import 'package:biblio/components/custom_button.dart';
import 'package:biblio/components/height.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/widgets/country_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectYourLocationScreen extends StatelessWidget {
  const SelectYourLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          spacing: 12.sp,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 6.sp,

              /// Header
              children: [
                Text(
                  'أين تود مشاركة كتبك؟',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SvgPicture.asset(
                  'assets/svg/books.svg',
                  height: 24.sp,
                ),
              ],
            ),
            Text(
              'من فضلك اختار الدولة والمدينة التي تود مشاركة الكتب بها',
              style: TextStyle(
                color: kTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const H(h: 5),

            /// Country
            Text(
              'الدولة',
              style: TextStyle(
                color: kMainColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const CountryDropdown(),

            /// City
            Text(
              'المدينة',
              style: TextStyle(
                color: kMainColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const CountryDropdown(),
          ],
        ),
      ),

      /// Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.sp,
          vertical: 24.sp,
        ),
        child: CustomButton(
          text: 'ابدأ التصفح',
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              NavigationBarApp.id,
            );
          },
        ),
      ),
    );
  }
}
