import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_user_conversations_state.dart';

class FetchUserConversationsCubit extends Cubit<FetchUserConversationsState> {
  FetchUserConversationsCubit() : super(FetchUserConversationsInitial());

  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> conversations = [];
  Future<void> fetchUserConversations() async {
    emit(FetchUserConversationsLoading());
    try {
      if (Supabase.instance.client.auth.currentUser?.id == null) {
      } else {
        final user = Supabase.instance.client.auth.currentUser!.id;

        final response = await supabase
            .from('conversation_participants')
            .select(
              'conversation_id, book_image, title_book, receiver, sender, conversations(created_at)',
            )
            .eq('user_id', user)
            .order('conversation_id', ascending: false);
        conversations = List<Map<String, dynamic>>.from(response);
      }
      emit(FetchUserConversationsSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(FetchUserConversationsError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FetchUserConversationsError(e.toString()));
    }
  }
}
