import 'dart:io';

import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Upload user photo
Future<void> uploadUserPhoto(BuildContext context) async {
  final supabase = Supabase.instance.client;

  /// اختيار الصورة باستخدام ImagePicker
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  /// التحقق من اختيار صورة
  if (pickedImage == null) {
    showSnackBar(context, 'لم يتم اختيار صورة.');

    return;
  }

  /// تحويل XFile إلى File
  final file = File(pickedImage.path);

  /// التحقق من تسجيل المستخدم
  final user = supabase.auth.currentUser;
  if (user == null) {
    showSnackBar(context, 'يوجد صعوبة في الوصول للمستخدم المُسجل.');

    return;
  }

  try {
    /// استرجاع رابط الصورة القديمة
    final response = await supabase
        .from('users')
        .select('image')

        /// حقل الصورة
        .eq('id', user.id)
        .single();

    if (response['image'] != null) {
      final oldPhotoUrl = response['image'] as String;

      /// استخراج اسم الملف من الرابط
      final oldFileName = oldPhotoUrl.split('/').last;

      /// حذف الصورة القديمة
      await supabase.storage.from('user-photos').remove([oldFileName]);
      //  showSnackBar(context,'تم حذف الصورة القديمة: $oldFileName' );
    }

    /// إنشاء اسم فريد للملف
    final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    /// رفع الملف إلى Supabase Storage
    await supabase.storage

        /// اسم الباكت Bucket الذي قمت بإنشائه في Supabase
        .from('user-photos')
        .upload(fileName, file);

    /// الحصول على رابط الصورة
    final photoUrl =
        supabase.storage.from('user-photos').getPublicUrl(fileName);

    /// حفظ رابط الصورة في جدول users
    final insertResponse = await supabase.from('users').update({
      'image': photoUrl,
    }).eq('id', user.id);

    if (insertResponse == null) {
      showSnackBar(
        context,
        // ignore: avoid_dynamic_calls
        '${insertResponse.error!.message} خطأ أثناء حفظ رابط الصورة',
      );
    }
    showSnackBar(context, 'تم الحفظ.');
  } catch (e) {
    // showSnackBar(context, 'حدث خطأ: $e');
  }
}
