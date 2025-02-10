import 'package:biblio/screens/chat/help_chat/help_chat_screen.dart';
import 'package:biblio/screens/more_page/widgets/acount_manegment_screen.dart';
import 'package:biblio/screens/more_page/widgets/category_for_more.dart';
import 'package:biblio/screens/more_page/widgets/faq_page.dart';
import 'package:biblio/screens/more_page/widgets/personal_card.dart';
import 'package:biblio/screens/more_page/widgets/sign_out_button.dart';
import 'package:biblio/screens/more_page/widgets/terms_and_conditions_page.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:flutter/material.dart';

class MoreWithLogin extends StatelessWidget {
  const MoreWithLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          const PersonalCard(),
          const H(h: 12),
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
          const H(h: 12),
          CategoryForMore(
            text: 'الأسئلة الشائعة',
            icon: Icons.help_outline_sharp,
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
          const H(h: 12),
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
          const H(h: 12),
          CategoryForMore(
            text: 'الدعم الفني',
            icon: Icons.headset_mic_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HelpChatScreen();
                  },
                ),
              );
            },
          ),
          const H(h: 12),
          const SignOutButton(),
        ],
      ),
    );
  }
}
