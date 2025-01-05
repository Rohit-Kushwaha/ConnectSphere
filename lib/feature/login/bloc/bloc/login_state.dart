part of 'login_bloc.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

final class UserLoggedInState extends LoginState {}

final class UserLoadingState extends LoginState {}

class UserNotVerifiedState extends LoginState {}

final class UserLoginErrorState extends LoginState {
  final String error;
  const UserLoginErrorState({required this.error});
}

class PasswordCheckState extends LoginState {
  final bool isVisible;

  const PasswordCheckState({required this.isVisible});
}
