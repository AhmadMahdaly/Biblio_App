import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

///
/// Get user photo
Future<String?> getUserPhoto() async {
  final supabase = Supabase.instance.client;

  final user = supabase.auth.currentUser;
  if (user == null) {
    if (kDebugMode) {
      print('المستخدم غير مسجل الدخول.');
    }
    return null;
  }

  try {
    // استرجاع رابط الصورة من قاعدة البيانات
    final response = await supabase
        .from('users')
        .select('image') // تحديد الحقل المطلوب
        .eq('id', user.id)
        .single(); // جلب سجل واحد فقط

    // التحقق من وجود بيانات
    if (response['image'] == null) {
      throw Exception('لم يتم العثور على الصورة للمستخدم.');
    }

    // استخراج رابط الصورة
    final photoUrl = response['image'] as String;

    return photoUrl;
  } catch (e) {
    if (kDebugMode) {
      print('حدث خطأ: $e');
    }
    return null;
  }
}
