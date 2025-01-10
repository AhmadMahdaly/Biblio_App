import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  /*Retrieve the current user and assign the value to the _user variable. Notice that
this page sets up a listener on the user's auth state using onAuthStateChange. */
  User? _user;
  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  Future<void> _getAuth() async {
    if (mounted) {
      setState(() {
        _user = supabase.auth.currentUser;
      });
    }

    supabase.auth.onAuthStateChange.listen((event) {
      if (mounted) {
        setState(() {
          _user = event.session?.user;
        });
      }
    });
  }

  final SupabaseClient supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return _user == null ? const OnboardScreen() : const NavigationBarApp();
  }
}
