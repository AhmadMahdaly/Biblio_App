import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchUnreadMessageCubit extends Cubit<AppStates> {
  FetchUnreadMessageCubit() : super(AppInitialState());
  final supabase = Supabase.instance.client;

  int notificationCount = 0;
  Future<void> fetchUnreadMessages(
    BuildContext context, {
    required String otherId,
  }) async {
    emit(AppLoadingState());
    try {
      String? user;
      if (Supabase.instance.client.auth.currentUser?.id == null) {
        user = null;
      } else {
        user = Supabase.instance.client.auth.currentUser?.id;
      }
      if (user != null) {
        final response = await supabase
            .from('messages')
            .select('content')
            .eq('is_read', false)
            .eq('other_id', user);
        final messages = List<Map<String, dynamic>>.from(response);
        notificationCount = messages.length;
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
