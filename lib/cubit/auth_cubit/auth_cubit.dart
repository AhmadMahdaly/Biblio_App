import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  SupabaseClient user = Supabase.instance.client;
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoading());
    try {
      await user.auth.signInWithPassword(email: email, password: password);

      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message ==
          'ClientException: Connection closed before full header was received') {
        await context.read<AuthCubit>().signOut(context);
      }
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
    required BuildContext context,
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
      });
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message ==
          'ClientException: Connection closed before full header was received') {
        await signOut(context);
      }
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
      emit(SignOutSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message ==
          'ClientException: Connection closed before full header was received') {}
      emit(SignOutError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SignOutError(e.toString()));
    }
  }
}
