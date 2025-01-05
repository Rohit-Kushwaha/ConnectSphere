// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginUserEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class CheckPasswordEvent extends LoginEvent {
  final bool isVisible;
  const CheckPasswordEvent({
    required this.isVisible,
  });

  @override
  List<Object> get props => [isVisible];
}
