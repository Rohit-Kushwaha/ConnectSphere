part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {}

class OtpSendingState extends OtpState {}

class OtpSendState extends OtpState {
  final String message;

  const OtpSendState({required this.message});
}

class OtpCheckingState extends OtpState {}

class OtpVerifiedState extends OtpState {}

class OtpErrorState extends OtpState {
  final String error;
  const OtpErrorState({required this.error});
}
