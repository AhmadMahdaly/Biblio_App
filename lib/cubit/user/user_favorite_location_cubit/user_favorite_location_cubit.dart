import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_favorite_location_state.dart';

class UserFavoriteLocationCubit extends Cubit<UserFavoriteLocationState> {
  UserFavoriteLocationCubit() : super(UserFavoriteLocationInitial());
  final SupabaseClient supabase = Supabase.instance.client;
  String? favoriteLocation;
  String? urlLocation;
  Future<void> getUserFavoriteLocation({
    required String userId,
  }) async {
    emit(UserFavoriteLocationLoading());
    try {
      final response = await supabase
          .from('users')
          .select('fav_location')
          .eq('id', userId)
          .single();
      favoriteLocation = response['fav_location'].toString();

      final urlLocationResponse = await supabase
          .from('users')
          .select('location_url')
          .eq('id', userId)
          .single();
      urlLocation = urlLocationResponse['location_url'].toString();

      emit(UserFavoriteLocationSuccess());
    } catch (e) {
      log(e.toString());
      emit(UserFavoriteLocationError(e.toString()));
    }
  }
}
