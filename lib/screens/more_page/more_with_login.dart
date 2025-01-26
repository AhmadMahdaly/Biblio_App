import 'package:biblio/screens/account_manegment/acount_manegment_screen.dart';
import 'package:biblio/screens/more_page/widgets/category_for_more.dart';
import 'package:biblio/screens/more_page/widgets/faq_page.dart';
import 'package:biblio/screens/more_page/widgets/personal_card.dart';
import 'package:biblio/screens/more_page/widgets/sign_out_button.dart';
import 'package:biblio/screens/more_page/widgets/terms_and_conditions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreWithLogin extends StatelessWidget {
  const MoreWithLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        spacing: 12.sp,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PersonalCard(),
          CategoryForMore(
            text: 'إدارة الحساب',
            icon: Icons.mode_edit_outline_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AcountManegmentScreen();
                  },
                ),
              );
            },
          ),
          CategoryForMore(
            text: 'الأسئلة الشائعة',
            icon: Icons.live_help_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const FAQPage();
                  },
                ),
              );
            },
          ),
          CategoryForMore(
            text: 'الشروط والأحكام',
            icon: Icons.text_snippet_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const TermsAndConditionsPage();
                  },
                ),
              );
            },
          ),
          const SignOutButton(),
        ],
      ),
    );
  }
}
