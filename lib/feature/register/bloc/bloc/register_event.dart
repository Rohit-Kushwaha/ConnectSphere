part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final String name, email, password;
  final bool isVerified;
  RegisterUserEvent(
      {required this.name, required this.email, required this.password,
      required this.isVerified});
}

class CheckPasswordEvent extends RegisterEvent {
  final bool value;
  CheckPasswordEvent({required this.value});
}

class FormFieldChangedEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  FormFieldChangedEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
