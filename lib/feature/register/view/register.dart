import 'package:career_sphere/feature/register/bloc/bloc/register_bloc.dart';
import 'package:career_sphere/feature/register/repo/register_repo.dart';
import 'package:career_sphere/feature/register/widget/custom_textfield.dart';
import 'package:career_sphere/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocProvider(
        create: (context) => RegisterBloc(RegisterRepoImpl()),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              spacing: 20.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidget(
                  controller: nameController,
                  labelText: 'Name',
                  hintText: 'Krishna',
                ),
                CustomTextWidget(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'radhe@gmail.com',
                ),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    bool value =
                        state is PasswordCheckState ? state.value : false;
                    return CustomTextWidget(
                        obscureText: value,
                        controller: passwordController,
                        labelText: 'Password',
                        hintText: '#4Ra23%c3p',
                        suffixIcon: GestureDetector(
                            onTap: () {
                              context
                                  .read<RegisterBloc>()
                                  .add(CheckPasswordEvent(value: value));
                            },
                            child: value
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined)));
                  },
                ),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is UserRegisterdState) {
                      context.go('/otp?email=${emailController.text}');
                    }
                    if (state is UserRegistrationErrorState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          context.read<RegisterBloc>().add(RegisterUserEvent(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              isVerified: false));
                        },
                        child: state is RegisterLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                                "Register",
                                style: merienda20(context),
                              ));
                  },
                ),
                GestureDetector(
                  onTap: () {
                    context.go('/login');
                  },
                  child: Text('Already have an account? Login',
                      style: merienda16(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
