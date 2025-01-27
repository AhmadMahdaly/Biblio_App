import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());
  bool isFavorite = false;
  SupabaseClient supabase = Supabase.instance.client;
  final user = Supabase.instance.client.auth.currentUser;

  Future<void> loadFavoriteState({
    required String bookId,
  }) async {
    emit(FavoriteButtonLoading());
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
      emit(FavoriteButtonSuccess());
    } on PostgrestException catch (e) {
      if (e.message ==
          'JSON object requested, multiple (or no) rows returned') {}
      emit(FavoriteButtonError(e.message));
    } on AuthException catch (e) {
      log(e.toString());
      emit(FavoriteButtonError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FavoriteButtonError(e.toString()));
    }
  }

  Future<void> toggleFavorite({
    required String bookId,
  }) async {
    emit(FavoriteButtonLoading());
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
      emit(FavoriteButtonSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(FavoriteButtonError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FavoriteButtonError(e.toString()));
    }
  }
}
