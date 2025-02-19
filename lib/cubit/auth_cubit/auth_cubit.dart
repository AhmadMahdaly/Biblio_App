import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCubit extends Cubit<AppStates> {
  AuthCubit() : super(AppInitialState());
  SupabaseClient user = Supabase.instance.client;
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AppLoadingState());
    try {
      await user.auth.signInWithPassword(email: email, password: password);

      emit(AppSuccessState());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message ==
          'ClientException: Connection closed before full header was received') {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (e.message ==
          'HandshakeException: Connection terminated during handshake') {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      emit(AppErrorState(e.message));
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AppLoadingState());
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
      emit(AppSuccessState());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message ==
          'ClientException: Connection closed before full header was received') {
        await signOut(context);
      }
      emit(AppErrorState(e.message));
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> signOut(BuildContext context) async {
    emit(AppLoadingState());
    try {
      await user.auth.signOut();
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
