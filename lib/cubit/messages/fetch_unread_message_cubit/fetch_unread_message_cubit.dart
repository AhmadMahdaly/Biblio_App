import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_unread_message_state.dart';

class FetchUnreadMessageCubit extends Cubit<FetchUnreadMessageState> {
  FetchUnreadMessageCubit() : super(FetchUnreadMessageInitial());
  final supabase = Supabase.instance.client;

  int notificationCount = 0;
  Future<void> fetchUnreadMessages() async {
    emit(FetchUnreadMessageLoading());
    try {
      final response = await supabase
          .from('messages')
          .select('content')
          .eq('is_read', false)
          .eq('other_id', supabase.auth.currentUser!.id);
      final messages = List<Map<String, dynamic>>.from(response);
      notificationCount = messages.length;
      emit(FetchUnreadMessageSuccess());
    } catch (e) {
      emit(FetchUnreadMessageError());
    }
  }
}
