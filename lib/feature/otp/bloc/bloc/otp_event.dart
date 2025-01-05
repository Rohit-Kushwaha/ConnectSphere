part of 'otp_bloc.dart';

sealed class OtpEvent {
  const OtpEvent();

  // @override
  // List<Object> get props => [];
}

class AutomaticOtpSentEvent extends OtpEvent {
  final String email;

  const AutomaticOtpSentEvent({required this.email});
  // @override
  // List<Object> get props => [email];
}

class ResendOtpSentEvent extends OtpEvent {
  final String email;

  const ResendOtpSentEvent({required this.email});
  // @override
  // List<Object> get props => [email];
}

class VerifyOtpEvent extends OtpEvent {
  final String email, otp;
  const VerifyOtpEvent({required this.email, required this.otp});
}