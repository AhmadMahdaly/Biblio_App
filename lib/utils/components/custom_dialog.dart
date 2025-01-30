import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          showDialog<bool?>(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: kLightBlue,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const H(h: 12),
                  Text(
                    'تم إرسال طلبك',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svg/Messages-pana.svg',
                    height: 200,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'يمكنك متابعة الطلبات المُرسلة وانتظار الردود في الطلبات',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const H(h: 12),
                  Container(
                    height: 40.sp,
                    width: 40.sp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kLightBlue,
                      borderRadius: BorderRadius.circular(320.sp),
                      border: Border.all(
                        width: 3.sp,
                        color: kMainColor,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        NavigationBarApp.id,
                        (route) => false,
                      ),
                      icon: Icon(
                        Icons.done,
                        color: kMainColor,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          return Container();
        },
      ),
    );
  }
}
