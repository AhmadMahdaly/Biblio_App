part of 'save_user_location_cubit.dart';

@immutable
sealed class SaveUserLocationState {}

final class SaveUserLocationInitial extends SaveUserLocationState {}

final class SaveUserLocationLoading extends SaveUserLocationState {}

final class SaveUserLocationSuccess extends SaveUserLocationState {}

final class SaveUserLocationError extends SaveUserLocationState {
  SaveUserLocationError(this.message);

  final String message;
}
