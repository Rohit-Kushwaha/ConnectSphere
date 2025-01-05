part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class UserRegisterdState extends RegisterState {}

class UserRegistrationErrorState extends RegisterState {
  final String error;
  UserRegistrationErrorState({required this.error});
}

class RegisterFormCompleteState extends RegisterState {}

class PasswordCheckState extends RegisterState {
  final bool value;
  PasswordCheckState({required this.value});
}

