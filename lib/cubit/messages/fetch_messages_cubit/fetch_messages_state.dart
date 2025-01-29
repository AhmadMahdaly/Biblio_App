part of 'fetch_messages_cubit.dart';

@immutable
sealed class FetchMessagesState {}

final class FetchMessagesInitial extends FetchMessagesState {}

final class FetchMessagesLoading extends FetchMessagesState {}

final class FetchMessagesSuccess extends FetchMessagesState {}

final class FetchMessagesError extends FetchMessagesState {
  FetchMessagesError(this.message);

  final String message;
}

class UpdateMessageLoading extends FetchMessagesState {}

class UpdateMessageSuccess extends FetchMessagesState {}

class UpdateMessageError extends FetchMessagesState {
  UpdateMessageError(this.message);
  final String message;
}
