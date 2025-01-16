import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kMainColor,
      decoration: InputDecoration(
        hintText: 'ابحث هنا “مائة عام من العزلة”',
        hintStyle: TextStyle(
          color: const Color(0xFF969697),
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
        ),
        prefixIcon: Container(
          margin: EdgeInsets.all(8.sp),
          padding: EdgeInsets.all(5.sp),
          width: 32.sp,
          height: 32.sp,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(
              8.sp,
            ),
          ),
          child: SvgPicture.asset(
            'assets/svg/Magnifier.svg',
            colorFilter: const ColorFilter.mode(
              Color(0xFF213555),
              BlendMode.srcIn,
            ),
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFECECEC),
        contentPadding: EdgeInsets.all(5.sp),
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(),
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(
          0xFFF4F4F4,
        ),
      ),
      borderRadius: BorderRadius.circular(10.sp),
    );
  }
}
