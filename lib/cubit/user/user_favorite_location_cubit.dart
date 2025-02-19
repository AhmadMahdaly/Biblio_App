import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserFavoriteLocationCubit extends Cubit<AppStates> {
  UserFavoriteLocationCubit() : super(AppInitialState());
  final SupabaseClient supabase = Supabase.instance.client;
  String? favoriteLocation;
  String? urlLocation;
  Future<void> getUserFavoriteLocation({
    required String userId,
    required BuildContext context,
  }) async {
    emit(AppLoadingState());
    try {
      final response = await supabase
          .from('books')
          .select('fav_location')
          .eq('book_id', userId)
          .single();
      favoriteLocation = response['fav_location'].toString();

      final urlLocationResponse = await supabase
          .from('books')
          .select('location_url')
          .eq('user_id', userId)
          .single();
      urlLocation = urlLocationResponse['location_url'].toString();
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
