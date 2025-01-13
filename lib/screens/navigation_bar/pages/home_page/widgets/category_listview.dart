import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryListview extends StatelessWidget {
  const CategoryListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.sp),
          width: 80.sp,
          height: 80.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.sp),
            color: const Color(0xFFECECEC),
          ),
          child: Column(
            children: [
              const H(h: 12),
              SvgPicture.asset(
                'assets/svg/ph_books.svg',
                height: 32.sp,
              ),
              Text(
                'روايات',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 6,
    );
  }
}
