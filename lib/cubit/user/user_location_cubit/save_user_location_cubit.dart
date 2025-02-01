import 'dart:developer';

import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'save_user_location_state.dart';

class SaveUserLocationCubit extends Cubit<SaveUserLocationState> {
  SaveUserLocationCubit() : super(SaveUserLocationInitial());
  String? selectedCountry;
  String? selectedCity;
  Future<void> saveUserData(BuildContext context) async {
    emit(SaveUserLocationLoading());
    try {
      final supabase = Supabase.instance.client;
      final user = Supabase.instance.client.auth.currentUser;
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
      await Navigator.pushReplacementNamed(
        context,
        NavigationBarApp.id,
      );
      emit(SaveUserLocationSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SaveUserLocationError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SaveUserLocationError(e.toString()));
    }
  }
}
