import 'package:career_sphere/feature/login/bloc/bloc/login_bloc.dart';
import 'package:career_sphere/feature/login/repo/login_repo.dart';
import 'package:career_sphere/feature/register/widget/custom_textfield.dart';
import 'package:career_sphere/utils/colors.dart';
import 'package:career_sphere/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
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
        create: (context) => LoginBloc(LoginRepoImpl()),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              spacing: 20.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidget(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'radhe@gmail.com',
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    bool isVisible =
                        state is PasswordCheckState ? state.isVisible : false;
                    return CustomTextWidget(
                        obscureText: isVisible,
                        controller: passwordController,
                        labelText: 'Password',
                        hintText: '#4Ra23%c3p',
                        suffixIcon: GestureDetector(
                            onTap: () {
                              context.read<LoginBloc>().add(
                                  CheckPasswordEvent(isVisible: isVisible));
                            },
                            child: isVisible
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined)));
                  },
                ),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is UserLoggedInState) {
                      context.go('/home');
                    }
                    if (state is UserLoginErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.error,
                            style: merienda16(context)
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      );
                    }
                    if (state is UserNotVerifiedState) {
                      context.go('/otp?email=${emailController.text}');
                    }
                  },
                  builder: (context, state) {
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
                          : Text(
                              "Submit",
                              style: merienda20(context),
                            ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    context.go('/register');
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: merienda16(context).copyWith(letterSpacing: .5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
