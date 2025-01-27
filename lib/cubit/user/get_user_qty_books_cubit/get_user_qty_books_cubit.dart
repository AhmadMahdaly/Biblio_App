import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_user_qty_books_state.dart';

class GetUserQtyBooksCubit extends Cubit<GetUserQtyBooksState> {
  GetUserQtyBooksCubit() : super(GetUserQtyBooksInitial());
  final supabase = Supabase.instance.client;
  List<dynamic> qtyBooks = [];

  Future<void> getUserQTYbooks(String userId) async {
    emit(GetUserQtyBooksLoading());
    try {
      final response = await supabase
          .from('books')
          // ignore: avoid_redundant_argument_values
          .select('*')
          .eq('user_id', userId);
      if (response != null) {
        qtyBooks = List<Map<String, dynamic>>.from(response);
      }
      emit(GetUserQtyBooksSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(GetUserQtyBooksError(e.message));
    } catch (e) {
      log(e.toString());
      emit(GetUserQtyBooksError(e.toString()));
    }
  }
}
