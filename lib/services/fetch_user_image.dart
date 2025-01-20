import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/supabase_instanse.dart';
import 'package:flutter/material.dart';

///
/// Get user photo
Future<String?> getUserPhoto(BuildContext context) async {
  if (user == null) {
    showSnackBar(context, 'يوجد صعوبة في الوصول للمستخدم المُسجل.');

    return null;
  }

  try {
    /// استرجاع رابط الصورة من قاعدة البيانات
    final response = await supabase
        .from('users')
        .select('image')

        /// تحديد الحقل المطلوب
        .eq('id', user!.id)
        .single();

    /// جلب سجل واحد فقط

    /// التحقق من وجود بيانات
    if (response['image'] == null) {
      showSnackBar(context, 'لم يتم العثور على الصورة للمستخدم.');
    }

    /// استخراج رابط الصورة
    final photoUrl = response['image'] as String;

    return photoUrl;
  } catch (e) {
    // showSnackBar(context, 'جاري العمل على حفظ الصورة!');
// 'حدث خطأ: $e'
    return null;
  }
}
