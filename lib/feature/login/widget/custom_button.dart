import 'package:career_sphere/feature/login/bloc/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.state});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<LoginBloc>().add(
                LoginUserEvent(
                    email: emailController.text,
                    password: passwordController.text),
              );
        },
        child: state is UserLoadingState
            ? Center(child: CircularProgressIndicator())
            : Text("Submit"));
  }
}
