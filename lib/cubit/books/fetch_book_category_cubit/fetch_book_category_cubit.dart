import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_book_category_state.dart';

class FetchBookCategoryCubit extends Cubit<FetchBookCategoryState> {
  FetchBookCategoryCubit() : super(FetchBookCategoryInitial());
  SupabaseClient supabase = Supabase.instance.client;
  List<String> categories = [];
  String? selectedCategory;

  /// Fetch Category
  Future<void> fetchCategories() async {
    emit(FetchBookCategoryLoading());
    try {
      final response = await supabase.from('categories').select('name');
      categories = response.map((e) => e['name'] as String).toList();
      emit(FetchBookCategorySuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(FetchBookCategoryError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FetchBookCategoryError(e.toString()));
    }
  }

  ///
}
