import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeleteBookCubit extends Cubit<AppStates> {
  DeleteBookCubit() : super(AppInitialState());
  SupabaseClient supabase = Supabase.instance.client;

  Future<void> deleteBook(
    Map<String, dynamic> book,
    BuildContext context,
  ) async {
    emit(AppLoadingState());
    try {
      final response = await Supabase.instance.client
          .from('books')
          .select('cover_image_url')
          .eq('id', book['id'].toString())
          .single();

      final oldPhotoUrl = response['cover_image_url'] as String;
      final oldFileName = oldPhotoUrl.split('/').last;
      await Supabase.instance.client.storage
          .from('book_covers')
          .remove([oldFileName]);

      final responsed = await Supabase.instance.client
          .from('books')
          .select('cover_book_url2')
          .eq('id', book['id'].toString())
          .single();
      final oldPhotoUrlI = responsed['cover_book_url2'] as String;
      final oldFileNameI = oldPhotoUrlI.split('/').last;

      await Supabase.instance.client.storage
          .from('book_covers')
          .remove([oldFileNameI]);
      await Supabase.instance.client.from('conversations').delete().eq(
            'book_id',
            book['id'].toString(),
          );

      await Supabase.instance.client.from('books').delete().eq(
            'id',
            book['id'].toString(),
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
      emit(AppErrorState(e.message));
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }
}
