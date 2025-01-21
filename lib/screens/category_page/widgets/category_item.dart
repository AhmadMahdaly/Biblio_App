import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.title,
    required this.icon,
    super.key,
    this.onTap,
  });
  final String title;
  final String icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              child: CachedNetworkImage(
                imageUrl: icon,
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
                  title,
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
      ),
    );
  }
}
