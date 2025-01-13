import 'package:biblio/services/fetch_user_name.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
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
        : SizedBox(
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
