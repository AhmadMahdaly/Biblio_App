import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'update_user_image_state.dart';

class UpdateUserImageCubit extends Cubit<UpdateUserImageState> {
  UpdateUserImageCubit() : super(UpdateUserImageInitial());
  final supabase = Supabase.instance.client;

  File? userImage;
  Future<void> pickImage() async {
    emit(PickUserImageLoading());
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );
      if (pickedFile != null) {
        userImage = File(pickedFile.path);
      }
      emit(PickUserImageSuccess());
    } catch (e) {
      log(e.toString());
      emit(PickUserImageError(e.toString()));
    }
  }

  Future<void> uploadImage() async {
    emit(UpdateUserImageInitial());
    try {
      if (userImage == null) {
        return;
      }

      /// رفع الصورة إلى Supabase Storage
      final fileName = DateTime.now().toIso8601String();
      await supabase.storage.from('user-photos').upload(
            fileName,
            userImage!,
          );
      final imageUrl =
          supabase.storage.from('user-photos').getPublicUrl(fileName);

      /// حفظ رابط الصورة في جدول users
      final response = await supabase
          .from('users')
          .select('image')
          .eq('id', supabase.auth.currentUser!.id)
          .single();
      final oldPhotoUrl = response['image'] as String;
      final oldFileName = oldPhotoUrl.split('/').last;

      /// حذف الصورة القديمة
      await supabase.storage.from('user-photos').remove([oldFileName]);
      await supabase.from('users').update({
        'image': imageUrl,
      }).eq(
        'id',
        supabase.auth.currentUser!.id,
      );
      await supabase.from('books').update({
        'user_image': imageUrl,
      }).eq(
        'user_id',
        supabase.auth.currentUser!.id,
      );
      emit(UpdateUserImageSuccess());
    } catch (e) {
      log(e.toString());
      emit(UpdateUserImageError(e.toString()));
    }
  }
}
