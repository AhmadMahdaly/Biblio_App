import 'package:biblio/screens/onboard_screen.dart';
import 'package:biblio/utils/components/border_radius.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreWithoutLogin extends StatelessWidget {
  const MoreWithoutLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Personal card
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(16.sp),
            width: MediaQuery.of(context).size.width,
            height: 98,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: borderRadius(),
            ),
            child: CustomBorderBotton(
              text: 'سجل الدخول',
              onTap: () {
                Navigator.pushReplacementNamed(context, OnboardScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
