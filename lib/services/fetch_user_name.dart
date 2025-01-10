import 'package:biblio/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient supabase = Supabase.instance.client;

String? userId; // ID المستخدم لتحديده بعد تسجيل الدخول

Future<void> fetchUserName(BuildContext context) async {
  try {
    // الحصول على المستخدم الحالي
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('المستخدم غير مسجل الدخول.');
    }

    // استعلام لإحضار اسم المستخدم
    final response = await supabase
        .from('users') // اسم الجدول
        .select('username') // العمود المطلوب
        .eq('id', user.id) // البحث باستخدام معرف المستخدم
        .single(); // استرجاع صف واحد فقط

    if (response['username'] == null) {
      throw Exception('اسم المستخدم غير موجود.');
    }

    return response['username'];
  } catch (e) {
    showSnackBar(
      context,
      'أوبس، هناك خطأ في تسجيل الدخول!',
      // e.toString(),
    );
  }
}
