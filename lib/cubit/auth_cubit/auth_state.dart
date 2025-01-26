part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginError extends AuthState {
  LoginError(this.message);

  final String message;
}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {}

final class SignUpError extends AuthState {
  SignUpError(this.message);

  final String message;
}

final class SignOutLoading extends AuthState {}

final class SignOutSuccess extends AuthState {}

final class SignOutError extends AuthState {
  SignOutError(this.message);

  final String message;
}
