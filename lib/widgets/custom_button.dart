import 'package:biblio/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    this.isActive = true,
    super.key,
  });

  final String text;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return isActive? Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 56.sp,
      decoration: ShapeDecoration(
        color: kMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    ):
     Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 56.sp,
      decoration: ShapeDecoration(
        color: kDisableButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: kTextShadowColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    )
    ;
  }
}

class CustomBorderBotton extends StatelessWidget {
  const CustomBorderBotton({
    required this.borderColor,
    required this.text,
    super.key,
  });

  final Color borderColor;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 56.sp,
      decoration: ShapeDecoration(
        color: kMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: kMainColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
