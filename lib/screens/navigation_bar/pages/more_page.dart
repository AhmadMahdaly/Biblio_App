import 'package:biblio/components/app_indicator.dart';
import 'package:biblio/components/custom_button.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/services/fetch_user_name.dart';
import 'package:biblio/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final SupabaseClient supabase = Supabase.instance.client;
  String? userId; // ID المستخدم لتحديده بعد تسجيل الدخول

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<dynamic>(
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
              }),
          CustomButton(
            padding: 16,
            text: 'تسجيل الخروج',
            onTap: () async {
              await supabase.auth.signOut();

              setState(() {
                Navigator.pushNamed(
                  context,
                  OnboardScreen.id,
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
