part of 'update_user_favorite_location_cubit.dart';

@immutable
sealed class UpdateUserFavoriteLocationState {}

final class UpdateUserFavoriteLocationInitial
    extends UpdateUserFavoriteLocationState {}

final class UpdateUserFavoriteLocationLoading
    extends UpdateUserFavoriteLocationState {}

final class UpdateUserFavoriteLocationSuccess
    extends UpdateUserFavoriteLocationState {}

final class UpdateUserFavoriteLocationError
    extends UpdateUserFavoriteLocationState {
  UpdateUserFavoriteLocationError(this.message);
  final String message;
}
