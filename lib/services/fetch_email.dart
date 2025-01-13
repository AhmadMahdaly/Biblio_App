import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient supabase = Supabase.instance.client;

String? userId; // ID المستخدم لتحديده بعد تسجيل الدخول

Future<void> fetchEmail(BuildContext context) async {
  try {
    // الحصول على المستخدم الحالي
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('المستخدم غير مسجل الدخول.');
    }

    // استعلام لإحضار اسم المستخدم
    final response = await supabase
        .from('users') // اسم الجدول
        .select('email') // العمود المطلوب
        .eq('id', user.id) // البحث باستخدام معرف المستخدم
        .single(); // استرجاع صف واحد فقط

    if (response['email'] == null) {
      throw Exception('البريد الإلكتروني غير موجود.');
    }

    return response['email'];
  } catch (e) {
    // e.toString(),
  }
}
