import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool?> showCustomDialog(
  BuildContext context,
  String text,
) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'تأكيد',
            style: TextStyle(
              color: kMainColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            text,
            style: TextStyle(
              color: kMainColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                true,
              ),
              child: Text(
                'نعم',
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(
                false,
              ),
              child: Text(
                'لا',
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
