import 'dart:developer';

import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_unread_message_state.dart';

class FetchUnreadMessageCubit extends Cubit<FetchUnreadMessageState> {
  FetchUnreadMessageCubit() : super(FetchUnreadMessageInitial());
  final supabase = Supabase.instance.client;

  int notificationCount = 0;
  Future<void> fetchUnreadMessages(BuildContext context,
      {required String otherId}) async {
    emit(FetchUnreadMessageLoading());
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
            // .eq('user_id', otherId)
            .eq('other_id', user);
        final messages = List<Map<String, dynamic>>.from(response);
        notificationCount = messages.length;
      }
      emit(FetchUnreadMessageSuccess());
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
      emit(FetchUnreadMessageError(e.message));
    } catch (e) {
      log(e.toString());

      emit(FetchUnreadMessageError(e.toString()));
    }
  }
}
