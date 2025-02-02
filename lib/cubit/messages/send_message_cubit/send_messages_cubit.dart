import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'send_messages_state.dart';

class SendMessagesCubit extends Cubit<SendMessagesState> {
  SendMessagesCubit() : super(SendMessagesInitial());
  final supabase = Supabase.instance.client;

  /// Send Message
  Future<void> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    emit(SendMessagesLoading());
    try {
      final userId = supabase.auth.currentUser?.id;
      await supabase.from('messages').insert({
        'conversation_id': conversationId,
        'user_id': userId ?? 11111,
        'content': content,
      });
      emit(SendMessagesSuccess());
    } on PostgrestException catch (e) {
      log(e.toString());
      if (e.message ==
          'JSON object requested, multiple (or no) rows returned') {}
    } on AuthException catch (e) {
      log(e.toString());
      emit(SendMessagesError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SendMessagesError(e.toString()));
    }
  }
}
