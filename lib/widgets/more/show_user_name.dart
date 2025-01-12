import 'package:biblio/components/app_indicator.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/services/fetch_user_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShowUserName extends StatefulWidget {
  const ShowUserName({
    super.key,
  });

  @override
  State<ShowUserName> createState() => _ShowUserNameState();
}

class _ShowUserNameState extends State<ShowUserName> {
  User? user = supabase.auth.currentUser;
  @override
  Widget build(BuildContext context) {
    return user == null
        ? SizedBox(
            height: 20.sp,
          )
        : FutureBuilder<dynamic>(
            future: fetchUserName(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AppIndicator();
              } else if (snapshot.hasError) {
                return const Text('');
                // خطأ: ${snapshot.error}
              } else {
                final userName = snapshot.data;
                return Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Text(
                    'أهلًـا $userName!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 16.sp,
                    ),
                  ),
                );
              }
            },
          );
  }
}
