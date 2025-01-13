import 'package:biblio/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({
    super.key,
  });

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await supabase.auth.signOut();
        await Navigator.popAndPushNamed(
          context,
          OnboardScreen.id,
        );
      },
      child: Text(
        'تسجيل الخروج',
        style: TextStyle(
          color: const Color(0xFFEA1C25),
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
