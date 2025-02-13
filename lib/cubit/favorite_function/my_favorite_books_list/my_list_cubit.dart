import 'dart:developer';

import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'my_list_state.dart';

class MyListCubit extends Cubit<MyListState> {
  MyListCubit() : super(MyListInitial());
  SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> books = [];
  String? user;
  Future<void> showMyFavoriteBooks(
    BuildContext context,
  ) async {
    emit(MyListLoading());
    try {
      if (supabase.auth.currentUser != null) {
        user = supabase.auth.currentUser!.id;

        /// جلب قائمة book_id من favorites
        final favoritesResponse = await supabase
            .from('favorites')
            .select('book_id')
            .eq('user_id', user!);
        if (favoritesResponse != null) {
          final bookIds =
              List<int>.from(favoritesResponse.map((item) => item['book_id']));

          /// جلب تفاصيل الكتب بناءً على book_id
          final booksResponse = await supabase
              .from('books')
              // ignore: avoid_redundant_argument_values
              .select('*')
              .filter(
                'id',

                /// استخدام in لتحديد الكتب المطلوبة
                'in',
                bookIds,
              );
          books = booksResponse;
        }
      }
      emit(MyListSuccess());
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
      emit(MyListError(e.message));
    } catch (e) {
      log(e.toString());
      emit(MyListError(e.toString()));
    }
  }
}
