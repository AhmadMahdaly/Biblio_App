import 'dart:developer';

import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_book_category_state.dart';

class FetchBookCategoryCubit extends Cubit<FetchBookCategoryState> {
  FetchBookCategoryCubit() : super(FetchBookCategoryInitial());
  SupabaseClient supabase = Supabase.instance.client;
  List<String> categories = [];
  String? selectedCategory;

  /// Fetch Category
  Future<void> fetchCategories(BuildContext context) async {
    emit(FetchBookCategoryLoading());
    final cubit = context.read<FetchBookCategoryCubit>();

    try {
      final response = await supabase
          .from('categories')
          .select('name')
          .order('id', ascending: true);
      categories = response.map((e) => e['name'] as String).toList();
      emit(FetchBookCategorySuccess());
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
      emit(FetchBookCategoryError(e.message));
    } catch (e) {
      log(e.toString());

      if (!cubit.isClosed) {
        emit(FetchBookCategoryError(e.toString()));
      }
    }
  }
}
