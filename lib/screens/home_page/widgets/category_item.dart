import 'package:biblio/screens/home_page/models/categories_model.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({required this.bookCategory, super.key});
  final CategoriesModel bookCategory;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(horizontal: 8.sp),
      width: 80.sp,
      height: 80.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        color: const Color(0xFFECECEC),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 5.sp,
        children: [
          const H(h: 5),
          SizedBox(
            child: Image.asset(
              bookCategory.icon,
              height: 32.sp,
              width: 32.sp,
              color: kMainColor,
            ),
          ),
          SizedBox(
            height: 40.sp,
            width: 70,
            child: Align(
              child: Text(
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                bookCategory.category,
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const H(h: 3),
        ],
      ),
    );
  }
}
