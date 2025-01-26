import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_order_type_book_state.dart';

class FetchOrderTypeBookCubit extends Cubit<FetchOrderTypeBookState> {
  FetchOrderTypeBookCubit() : super(FetchOrderTypeBookInitial());
  SupabaseClient supabase = Supabase.instance.client;
  List<String> offerTypes = [];
  String? selectedOffer;

  /// Fetch Category
  Future<void> fetchOrderType() async {
    emit(FetchOrderTypeBookLoading());
    try {
      final response = await supabase.from('offer_type').select('type');
      offerTypes = response.map((e) => e['type'] as String).toList();
      emit(FetchOrderTypeBookSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(FetchOrderTypeBookError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FetchOrderTypeBookError(e.toString()));
    }
  }
}
