import 'package:biblio/services/fetch_user_name.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowUserName extends StatelessWidget {
  const ShowUserName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.sp,
      child: FutureBuilder<dynamic>(
        future: fetchUserName(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppIndicator(
              size: 10,
            );
          } else if (snapshot.hasError) {
            return const Text('');
            // خطأ: ${snapshot.error}
          } else {
            final userName = snapshot.data;
            return Text(
              userName.toString(),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: kMainColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            );
          }
        },
      ),
    );
  }
}
