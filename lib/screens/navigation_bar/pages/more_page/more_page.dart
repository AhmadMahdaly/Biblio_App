import 'package:biblio/screens/navigation_bar/pages/more_page/widgets/show_user_name.dart';
import 'package:biblio/screens/onboard_screen.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:flutter/material.dart';
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
          const ShowUserName(),
          CustomButton(
            padding: 16,
            text: 'تسجيل الخروج',
            onTap: () async {
              await supabase.auth.signOut();
              await Navigator.popAndPushNamed(
                context,
                OnboardScreen.id,
              );
            },
          ),
        ],
      ),
    );
  }
}
