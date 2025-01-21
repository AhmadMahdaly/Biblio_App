import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient supabase = Supabase.instance.client;
Future<void> signInAsGuest(BuildContext context) async {
  try {
    // final response =
    await supabase.auth.signInAnonymously();
    // if (response.user != null) {
    //   print('User signed in as guest: ${response.user!.id}');
    //   // يمكنك استخدام id لتخزين بيانات المستخدم
    // } else {
    //   print('Failed to sign in as guest.');
    // }
  } catch (e) {
    showSnackBar(context, 'خطأ $e');
  }
}
