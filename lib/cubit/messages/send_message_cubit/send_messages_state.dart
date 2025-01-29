part of 'send_messages_cubit.dart';

@immutable
sealed class SendMessagesState {}

final class SendMessagesInitial extends SendMessagesState {}

final class SendMessagesLoading extends SendMessagesState {}

final class SendMessagesSuccess extends SendMessagesState {}

final class SendMessagesError extends SendMessagesState {
  SendMessagesError(this.message);

  final String message;
}
