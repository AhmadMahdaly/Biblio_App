import 'package:biblio/services/fetch_email.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShowEmail extends StatefulWidget {
  const ShowEmail({
    super.key,
  });

  @override
  State<ShowEmail> createState() => _ShowEmailState();
}

class _ShowEmailState extends State<ShowEmail> {
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
              future: fetchEmail(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const AppIndicator(
                    size: 10,
                  );
                } else if (snapshot.hasError) {
                  return const Text('');
                  // خطأ: ${snapshot.error}
                } else {
                  final email = snapshot.data;
                  return Text(
                    email.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }
              },
            ),
          );
  }
}
