import 'dart:developer';

import 'package:biblio/cubit/auth_cubit/auth_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_located_books_state.dart';

class FetchLocatedBooksCubit extends Cubit<FetchLocatedBooksState> {
  FetchLocatedBooksCubit() : super(FetchLocatedBooksInitial());
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> books = [];
  // List<Map<String, dynamic>> countryBooks = [];

  Future<void> fetchLocatedBooks(BuildContext context) async {
    emit(FetchLocatedBooksLoading());
    final cubit = context.read<FetchLocatedBooksCubit>();
    try {
      String? user;
      if (Supabase.instance.client.auth.currentUser?.id == null) {
        user = null;
      } else {
        user = Supabase.instance.client.auth.currentUser?.id;
      }
      if (user != null) {
        final responsed =
            await supabase.from('users').select('city').eq('id', user).single();

        final city = responsed['city'] as String;
        final response = await supabase
            .from('books')
            // ignore: avoid_redundant_argument_values
            .select('*')
            .eq('city', city)
            .order('created_at', ascending: false);
        books = List<Map<String, dynamic>>.from(response);
      }

      emit(FetchLocatedBooksSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message ==
          'ClientException: Connection closed before full header was received') {
        await context.read<AuthCubit>().signOut(context);
      }
      emit(FetchLocatedBooksError(e.message));
    } catch (e) {
      log(e.toString());
      if (!cubit.isClosed) {
        emit(FetchLocatedBooksError(e.toString()));
      }
    }
  }
}
