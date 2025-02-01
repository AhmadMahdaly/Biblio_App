part of 'user_favorite_location_cubit.dart';

@immutable
sealed class UserFavoriteLocationState {}

final class UserFavoriteLocationInitial extends UserFavoriteLocationState {}

final class UserFavoriteLocationLoading extends UserFavoriteLocationState {}

final class UserFavoriteLocationSuccess extends UserFavoriteLocationState {}

final class UserFavoriteLocationError extends UserFavoriteLocationState {
  UserFavoriteLocationError(this.message);
  final String message;
}
