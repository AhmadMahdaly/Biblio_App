import 'package:biblio/utils/constants/supabase_instanse.dart';
import 'package:flutter/material.dart';

/// Get book photo
Future<String?> getBooksPhoto(
  BuildContext context,
  int id,
) async {
  try {
    /// استرجاع رابط الصورة من قاعدة البيانات
    final response = await supabase
        .from('books')
        .select('cover_image_url')
        .eq('id', id)
        .single();

    /// استخراج رابط الصورة
    final photoUrl = response['cover_image_url'] as String;
    return photoUrl;
  } catch (e) {
    // showSnackBar(context, 'جاري العمل على حفظ الصورة!');
// 'حدث خطأ: $e'
    return null;
  }
}

Future<String?> getBooksPhotoI(
  BuildContext context,
  int id,
) async {
  try {
    /// استرجاع رابط الصورة من قاعدة البيانات
    final response = await supabase
        .from('books')
        .select('cover_book_url2')
        .eq('id', id)
        .single();

    /// استخراج رابط الصورة
    final photoUrl = response['cover_book_url2'] as String;
    return photoUrl;
  } catch (e) {
    // showSnackBar(context, 'جاري العمل على حفظ الصورة!');
// 'حدث خطأ: $e'
    return null;
  }
}
