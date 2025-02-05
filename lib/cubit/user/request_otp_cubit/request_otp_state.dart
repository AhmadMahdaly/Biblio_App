part of 'request_otp_cubit.dart';

@immutable
sealed class RequestOtpState {}

final class RequestOtpInitial extends RequestOtpState {}

final class RequestOtpLoading extends RequestOtpState {}

final class RequestOtpSuccess extends RequestOtpState {}

final class RequestOtpError extends RequestOtpState {
  RequestOtpError(this.message);
  final String message;
}
