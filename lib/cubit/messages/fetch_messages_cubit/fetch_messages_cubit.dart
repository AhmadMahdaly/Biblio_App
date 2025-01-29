import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_messages_state.dart';

class FetchMessagesCubit extends Cubit<FetchMessagesState> {
  FetchMessagesCubit() : super(FetchMessagesInitial());
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> messages = [];
  String? bookImg;
  String? titleBook;

  /// fetch Messages
  Future<void> fetchMessages({required String conversationId}) async {
    emit(FetchMessagesLoading());
    try {
      final response = await supabase
          .from('messages')
          .select('content, created_at, user_id')
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: true);
      messages = List<Map<String, dynamic>>.from(response);
      final responsed = await supabase
          .from('conversations')
          .select('book_image')
          .eq('id', conversationId)
          .single();
      bookImg = responsed['book_image'] as String;
      final responsee = await supabase
          .from('conversations')
          .select('title_book')
          .eq('id', conversationId)
          .single();
      titleBook = responsee['title_book'] as String;
      emit(FetchMessagesSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(FetchMessagesError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FetchMessagesError(e.toString()));
    }
  }
}
