import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SaveUserLocationCubit extends Cubit<AppStates> {
  SaveUserLocationCubit() : super(AppInitialState());
  String? selectedCountry;
  String? selectedCity;
  Future<void> saveUserData(BuildContext context) async {
    emit(AppLoadingState());
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user != null) {
        final userId = user.id;
        await supabase.from('users').update({
          'country': selectedCountry,
          'city': selectedCity,
        }).eq('id', userId);
        await supabase.from('books').update({
          'country': selectedCountry,
          'city': selectedCity,
        }).eq('user_id', userId);
      }

      emit(AppSuccessState());
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
      emit(AppErrorState(e.message));
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }
}
