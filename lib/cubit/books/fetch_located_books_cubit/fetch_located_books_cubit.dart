import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_located_books_state.dart';

class FetchLocatedBooksCubit extends Cubit<FetchLocatedBooksState> {
  FetchLocatedBooksCubit() : super(FetchLocatedBooksInitial());
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> books = [];
  // List<Map<String, dynamic>> countryBooks = [];

  Future<void> fetchLocatedBooks() async {
    emit(FetchLocatedBooksLoading());
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final responsed = await supabase
            .from('users')
            .select('city')
            .eq('id', user.id)
            .single();

        final city = responsed['city'] as String;
        final response = await supabase
            .from('books')
            // ignore: avoid_redundant_argument_values
            .select('*')
            .eq('city', city)
            .order('created_at', ascending: false);
        books = List<Map<String, dynamic>>.from(response);
      }

      // final uuser = supabase.auth.currentUser;
      // if (uuser != null) {
      //   final getCountry = await supabase
      //       .from('users')
      //       .select('country')
      //       .eq('id', uuser.id)
      //       .single();
      //   final country = getCountry['country'] as String;
      //   final responsee = await supabase
      //       .from('books')
      //       // ignore: avoid_redundant_argument_values
      //       .select('*')
      //       .eq('country', country)
      //       .order('created_at', ascending: false);
      //   countryBooks = List<Map<String, dynamic>>.from(responsee);
      // }
      emit(FetchLocatedBooksSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(FetchLocatedBooksError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FetchLocatedBooksError(e.toString()));
    }
  }
}
