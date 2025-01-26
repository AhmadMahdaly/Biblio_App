import 'dart:developer';

import 'package:biblio/screens/onboard/onboard_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  SupabaseClient user = Supabase.instance.client;
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await user.auth.signInWithPassword(email: email, password: password);

      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginError(e.message));
    } catch (e) {
      log(e.toString());
      emit(LoginError(e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      await user.auth.signUp(
        email: email,
        password: password,
        data: {'Display name': name},
      );
      await user.from('users').insert({
        // ربط المستخدم باستخدام UID
        'id': user.auth.currentUser!.id,
        'username': name,
        'email': email,
        'password': password,
      });
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SignUpError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> signOut(BuildContext context) async {
    emit(SignOutLoading());
    try {
      await user.auth.signOut();
      await Navigator.pushReplacementNamed(
        context,
        OnboardScreen.id,
      );
      emit(SignOutSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SignOutError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SignOutError(e.toString()));
    }
  }
}
