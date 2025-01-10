import 'package:biblio/components/custom_button.dart';
import 'package:biblio/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
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
