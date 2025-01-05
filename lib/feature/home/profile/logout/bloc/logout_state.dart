part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutWaitingState extends LogoutState {}

final class LogoutFailedState extends LogoutState {
  final String error;

  const LogoutFailedState({required this.error});
}

final class LogoutSucess extends LogoutState {}
