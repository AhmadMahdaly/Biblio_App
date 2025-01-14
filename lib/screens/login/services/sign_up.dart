import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient supabase = Supabase.instance.client;

/// Sign Up
Future<AuthResponse> signUp(
  String userName,
  String password,
  TextEditingController emailController,
  TextEditingController passwordController,
) {
  return supabase.auth.signUp(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
    data: {
      'name': userName,
      'password': password,
    },
  );
}
