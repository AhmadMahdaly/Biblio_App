import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_messages_state.dart';

class FetchMessagesCubit extends Cubit<FetchMessagesState> {
  FetchMessagesCubit() : super(FetchMessagesInitial());
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> messages = [];

  /// fetch Messages
  Future<void> fetchMessages({required String conversationId}) async {
    emit(FetchMessagesLoading());
    try {
      final response = await supabase
          .from('messages')
          .select('content, created_at, user_id')
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: false);
      messages = List<Map<String, dynamic>>.from(response);
      // for (var i = 0; i < messages.length; i++) {
      //   if (messages[i]['is_read'] == false) {
      //     messages[i]['is_read'] = true;
      //   }   }

      emit(FetchMessagesSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(FetchMessagesError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FetchMessagesError(e.toString()));
    }
  }

  Future<void> updateMessage({
    required String conversationId,
    required String messageId,
  }) async {
    emit(UpdateMessageLoading());
    try {
      await supabase
          .from('messages')
          .update({'is_read': true})
          .eq('conversation_id', conversationId)
          .eq('id', messageId);
      emit(UpdateMessageSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(UpdateMessageError(e.message));
    } catch (e) {
      log(e.toString());
      emit(UpdateMessageError(e.toString()));
    }
  }
}
