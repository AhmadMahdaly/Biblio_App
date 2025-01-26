import 'package:biblio/animations/animate_do.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyFavoriteBooks extends StatelessWidget {
  const EmptyFavoriteBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFadeInRight(
      duration: 300,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/Reading glasses-cuate.svg',
              height: 100.sp,
            ),
            Text(
              'هذه الفئة فارغة! لم تتم إضافة كتب بعد',
              style: TextStyle(
                color: kTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
