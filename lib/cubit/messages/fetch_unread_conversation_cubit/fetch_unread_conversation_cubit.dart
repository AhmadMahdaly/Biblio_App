import 'dart:developer';

import 'package:biblio/cubit/messages/fetch_unread_message_cubit/fetch_unread_message_cubit.dart';
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
  Future<void> fetchUnreadMessages({required String conversationId}) async {
    emit(FetchUnreadConversationLoading());
    try {
      final response = await supabase
          .from('messages')
          .select('content')
          .eq('is_read', false)
          .eq('conversation_id', conversationId)
          .eq('other_id', supabase.auth.currentUser!.id);

      if (response != null) {}
      final con = List<Map<String, dynamic>>.from(response);
      notificationCount = con.length;
      if (con == null) {
        isRead = true;
      }
      emit(FetchUnreadConversationSuccess());
    } catch (e) {
      log(e.toString());
      emit(FetchUnreadConversationError());
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
          .eq('other_id', supabase.auth.currentUser!.id)
          .eq('conversation_id', conversationId)
          .eq('is_read', false);
      context.read<FetchUnreadMessageCubit>().notificationCount = 0;
      notificationCount = 0;
    } catch (e) {
      log(e.toString());
      emit(FetchUnreadConversationError());
    }
  }
}
