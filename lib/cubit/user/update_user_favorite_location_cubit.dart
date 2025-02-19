import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateUserFavoriteLocationCubit extends Cubit<AppStates> {
  UpdateUserFavoriteLocationCubit() : super(AppInitialState());
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> updateUserFavoriteLocation(
    String favoriteLocations,
    String url,
    BuildContext context, {
    required String userId,
  }) async {
    emit(AppLoadingState());
    try {
      await supabase.from('books').update({
        'location_url': url,
        'fav_location': favoriteLocations,
      }).eq('user_id', userId);
      await supabase.from('users').update({
        'location_url': url,
        'fav_location': favoriteLocations,
      }).eq('id', userId);
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
