import 'dart:developer';

import 'package:biblio/cubit/auth_cubit/auth_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_order_type_book_state.dart';

class FetchOrderTypeBookCubit extends Cubit<FetchOrderTypeBookState> {
  FetchOrderTypeBookCubit() : super(FetchOrderTypeBookInitial());
  SupabaseClient supabase = Supabase.instance.client;
  List<String> offerTypes = [];
  String? selectedOffer;

  /// Fetch order type
  Future<void> fetchOrderType(BuildContext context) async {
    emit(FetchOrderTypeBookLoading());
    final cubit = context.read<FetchOrderTypeBookCubit>();

    try {
      final response = await supabase.from('offer_type').select('type');
      offerTypes = response.map((e) => e['type'] as String).toList();
      emit(FetchOrderTypeBookSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message ==
          'ClientException: Connection closed before full header was received') {
        await context.read<AuthCubit>().signOut(context);
      }
      emit(FetchOrderTypeBookError(e.message));
    } catch (e) {
      log(e.toString());
      if (!cubit.isClosed) {
        emit(FetchOrderTypeBookError(e.toString()));
      }
    }
  }
}
