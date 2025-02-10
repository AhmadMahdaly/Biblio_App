part of 'fetch_unread_message_cubit.dart';

@immutable
sealed class FetchUnreadMessageState {}

final class FetchUnreadMessageInitial extends FetchUnreadMessageState {}

final class FetchUnreadMessageLoading extends FetchUnreadMessageState {}

final class FetchUnreadMessageSuccess extends FetchUnreadMessageState {}

final class FetchUnreadMessageError extends FetchUnreadMessageState {}
