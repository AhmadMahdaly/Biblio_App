import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteButtonCubit extends Cubit<AppStates> {
  FavoriteButtonCubit() : super(AppInitialState());
  bool isFavorite = false;
  SupabaseClient supabase = Supabase.instance.client;
  final user = Supabase.instance.client.auth.currentUser;

  Future<void> loadFavoriteState(
    BuildContext context, {
    required String bookId,
  }) async {
    isFavorite = false;
    emit(AppLoadingState());
    try {
      if (user != null) {
        final userId = user!.id;
        final response = await supabase
            .from('favorites')
            .select()
            .eq('user_id', userId)
            .eq('book_id', bookId)
            .maybeSingle();
        if (response != null) {
          isFavorite = true;
        }
      }
      emit(AppSuccessState());
    } on PostgrestException catch (e) {
      if (e.message ==
          'JSON object requested, multiple (or no) rows returned') {}
      emit(AppErrorState(e.message));
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message ==
          'ClientException: Connection closed before full header was received') {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (e.message ==
          'HandshakeException: Connection terminated during handshake') {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      emit(AppErrorState(e.message));
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> toggleFavorite({
    required String bookId,
    required BuildContext context,
  }) async {
    emit(AppLoadingState());
    try {
      final userId = supabase.auth.currentUser!.id;
      if (isFavorite) {
        // إزالة من المفضلة
        await supabase
            .from('favorites')
            .delete()
            .eq('user_id', userId)
            .eq('book_id', bookId);
      } else {
        // إضافة إلى المفضلة
        await supabase.from('favorites').insert({
          'user_id': userId,
          'book_id': bookId,
        });
      }

      isFavorite = !isFavorite;
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
