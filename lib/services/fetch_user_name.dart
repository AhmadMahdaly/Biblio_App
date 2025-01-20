import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/supabase_instanse.dart';
import 'package:flutter/material.dart';

String? userId;

/// ID المستخدم لتحديده بعد تسجيل الدخول

Future<void> fetchUserName(BuildContext context) async {
  try {
    /// الحصول على المستخدم الحالي

    if (user == null) {
      showSnackBar(context, 'يوجد صعوبة في الوصول للمستخدم المُسجل.');
      throw Exception('المستخدم غير مسجل الدخول.');
    }

    /// استعلام لإحضار اسم المستخدم
    final response = await supabase
        .from('users')

        /// اسم الجدول
        .select('username')

        /// العمود المطلوب
        .eq('id', user!.id)

        /// البحث باستخدام معرف المستخدم
        .single();

    /// استرجاع صف واحد فقط

    if (response['username'] == null) {
      showSnackBar(context, 'اسم المستخدم غير موجود.');
    }

    return response['username'];
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}
