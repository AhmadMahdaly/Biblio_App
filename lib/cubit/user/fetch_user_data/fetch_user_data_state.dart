part of 'fetch_user_data_cubit.dart';

@immutable
sealed class FetchUserDataState {}

final class FetchUserDataLoading extends FetchUserDataState {}

final class FetchUserDataSuccess extends FetchUserDataState {}

final class FetchUserDataError extends FetchUserDataState {
  FetchUserDataError(this.message);
  final String message;
}
