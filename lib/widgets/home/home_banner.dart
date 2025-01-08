import 'package:biblio/components/width.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.sp),
          width: MediaQuery.of(context).size.width,
          height: 140.sp,
          child: Image.asset(
            'assets/images/home_banner.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.sp),
          child: Column(
            spacing: 12.sp,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اقرأ وبدِّل',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const W(w: 5),
                  SvgPicture.asset(
                    'assets/svg/logo.svg',
                    height: 24.sp,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              Align(
                child: Text(
                  'تمتلك الكثير من الكتب وترغب في عرضها للتبادل أو للبيع؟',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 8.sp),
                  width: 131,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Text(
                    'ابدأ الآن',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
