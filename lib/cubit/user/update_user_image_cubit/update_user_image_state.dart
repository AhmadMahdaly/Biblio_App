part of 'update_user_image_cubit.dart';

@immutable
sealed class UpdateUserImageState {}

final class UpdateUserImageInitial extends UpdateUserImageState {}

final class UpdateUserImageLoading extends UpdateUserImageState {}

final class UpdateUserImageSuccess extends UpdateUserImageState {}

final class UpdateUserImageError extends UpdateUserImageState {
  UpdateUserImageError(this.message);
  final String message;
}

final class PickUserImageLoading extends UpdateUserImageState {}

final class PickUserImageSuccess extends UpdateUserImageState {}

final class PickUserImageError extends UpdateUserImageState {
  PickUserImageError(this.message);
  final String message;
}
