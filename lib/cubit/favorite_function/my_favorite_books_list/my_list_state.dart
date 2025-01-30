part of 'my_list_cubit.dart';

@immutable
sealed class MyListState {}

final class MyListInitial extends MyListState {}

final class MyListLoading extends MyListState {}

final class MyListSuccess extends MyListState {}

final class MyListError extends MyListState {
  MyListError(this.message);

  final String message;
}
