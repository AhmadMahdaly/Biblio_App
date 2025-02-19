import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchOrderTypeBookCubit extends Cubit<AppStates> {
  FetchOrderTypeBookCubit() : super(AppInitialState());
  SupabaseClient supabase = Supabase.instance.client;
  List<String> offerTypes = [];
  String? selectedOffer;

  /// Fetch order type
  Future<void> fetchOrderType(BuildContext context) async {
    emit(AppLoadingState());
    final cubit = context.read<FetchOrderTypeBookCubit>();

    try {
      final response = await supabase.from('offer_type').select('type');
      offerTypes = response.map((e) => e['type'] as String).toList();
      if (!cubit.isClosed) {
        emit(AppSuccessState());
      }
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message.contains(
        'Connection reset by peer',
      )) {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (e.message.contains(
        'Connection closed before full header was received',
      )) {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (e.message.contains(
        'Connection terminated during handshake',
      )) {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (!cubit.isClosed) {
        emit(AppErrorState(e.toString()));
      }
    } catch (e) {
      log(e.toString());
      if (!cubit.isClosed) {
        emit(AppErrorState(e.toString()));
      }
    }
  }
}
