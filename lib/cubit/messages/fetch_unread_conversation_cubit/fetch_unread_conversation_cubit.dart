import 'dart:developer';

import 'package:biblio/cubit/messages/fetch_unread_message_cubit/fetch_unread_message_cubit.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_unread_conversation_state.dart';

class FetchUnreadConversationCubit extends Cubit<FetchUnreadConversationState> {
  FetchUnreadConversationCubit() : super(FetchUnreadConversationInitial());
  final supabase = Supabase.instance.client;
  int notificationCount = 0;
  bool isRead = true;
  Future<void> fetchUnreadCon(
    BuildContext context, {
    required String conversationId,
    required String otherId,
  }) async {
    emit(FetchUnreadConversationLoading());
    try {
      final response = await supabase
          .from('messages')
          .select('content')
          .eq('is_read', false)
          .eq('conversation_id', conversationId)
          // .eq('user_id', otherId)
          .eq('other_id', Supabase.instance.client.auth.currentUser!.id);

      if (response != null) {}
      final con = List<Map<String, dynamic>>.from(response);
      notificationCount = con.length;
      if (con == null) {
        isRead = true;
      }
      emit(FetchUnreadConversationSuccess());
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
      emit(FetchUnreadConversationError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FetchUnreadConversationError(e.toString()));
    }
  }

  Future<void> markMessagesAsRead({
    required String conversationId,
    required BuildContext context,
  }) async {
    try {
      await supabase
          .from('messages')
          .update({'is_read': true})
          .eq('other_id', Supabase.instance.client.auth.currentUser!.id)
          .eq('conversation_id', conversationId)
          .eq('is_read', false);
      context.read<FetchUnreadMessageCubit>().notificationCount = 0;
      notificationCount = 0;
    } catch (e) {
      log(e.toString());
      emit(FetchUnreadConversationError(e.toString()));
    }
  }
}
