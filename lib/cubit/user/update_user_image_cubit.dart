import 'dart:developer';
import 'dart:io';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateUserImageCubit extends Cubit<AppStates> {
  UpdateUserImageCubit() : super(AppInitialState());
  final supabase = Supabase.instance.client;

  Future<void> uploadImage(File userImage, BuildContext context) async {
    emit(AppLoadingState());
    try {
      if (userImage == null) {
        return;
      }

      /// رفع الصورة إلى Supabase Storage
      final fileName = DateTime.now().toIso8601String();
      await supabase.storage.from('user-photos').upload(
            fileName,
            userImage,
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
      emit(AppSuccessState());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message.contains(
        'Connection reset by peer',
      )) {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (e.message.contains(
        'Connection closed before full header was received',
      )) {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (e.message.contains(
        'Connection terminated during handshake',
      )) {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }
}
