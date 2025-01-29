import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'create_conversation_state.dart';

class CreateConversationCubit extends Cubit<CreateConversationState> {
  CreateConversationCubit() : super(CreateConversationInitial());
  final supabase = Supabase.instance.client;
  int? conversationId;
  String? otherUserId;

  /// Create Conversation
  Future<void> createConversation({
    required String otherId,
    required String titleBook,
    required String bookImg,
  }) async {
    emit(CreateConversationLoading());
    try {
      final userId = supabase.auth.currentUser!.id;
      otherUserId = otherId;

      final response = await supabase
          .from('conversations')
          .insert({
            'book_image': bookImg,
            'title_book': titleBook,
          })
          .select('id')
          .single();
      conversationId = response['id'] as int;
      // إضافة المستخدمين إلى المحادثة
      await supabase.from('conversation_participants').insert([
        {'conversation_id': conversationId, 'user_id': userId},
        {'conversation_id': conversationId, 'user_id': otherId},
      ]);

      emit(CreateConversationSeccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(CreateConversationError(e.message));
    } catch (e) {
      log(e.toString());
      emit(CreateConversationError(e.toString()));
    }
  }
}
