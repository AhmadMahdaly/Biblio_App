import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'update_user_favorite_location_state.dart';

class UpdateUserFavoriteLocationCubit
    extends Cubit<UpdateUserFavoriteLocationState> {
  UpdateUserFavoriteLocationCubit()
      : super(UpdateUserFavoriteLocationInitial());
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> updateUserFavoriteLocation(
    String favoriteLocations,
    String url, {
    required String userId,
  }) async {
    emit(UpdateUserFavoriteLocationLoading());
    try {
      await supabase.from('users').update({
        'location_url': url,
        'fav_location': favoriteLocations,
      }).eq('id', userId);

      emit(UpdateUserFavoriteLocationSuccess());
    } catch (e) {
      log(e.toString());
      emit(UpdateUserFavoriteLocationError(e.toString()));
    }
  }
}
