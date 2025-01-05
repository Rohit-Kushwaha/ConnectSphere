import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/feature/register/model/req/register_req.dart';
import 'package:career_sphere/feature/register/repo/register_repo.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepo registerRepo;
  RegisterBloc(this.registerRepo) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});

    on<RegisterUserEvent>((event, emit) async {
      if (event.name.isEmpty) {
        return emit(UserRegistrationErrorState(error: "Name can't be empty"));
      }
      if (event.name.length < 3) {
        return emit(UserRegistrationErrorState(
            error: "Name must contain at least 3 characters"));
      }
      if (event.password.length < 6) {
        return emit(UserRegistrationErrorState(
            error: "Password must be at least 6 characters"));
      }
      if (event.email.isEmpty || !event.email.contains('@')) {
        return emit(UserRegistrationErrorState(error: "Invalid email"));
      }
      emit(RegisterLoadingState());

      try {
        // Create a request model
        final requestModel = RegisterRequestModel(
            name: event.name,
            email: event.email,
            password: event.password,
            isVerified: event.isVerified);

        // Send data to the API
        await registerRepo.registerUser(
          requestModel: requestModel,
        );

        /// Saving user data
        await SharedPrefHelper.instance.saveData('name', event.name);
        await SharedPrefHelper.instance.saveData('email', event.email);

        emit(UserRegisterdState());
      } on ErrorResponseModel catch (error) {
        emit(UserRegistrationErrorState(error: error.message));
      } catch (e) {
        emit(UserRegistrationErrorState(error: "An unexpected error occurred"));
      }
    });

    on<CheckPasswordEvent>((event, emit) {
      emit(PasswordCheckState(value: !event.value));
    });

    on<FormFieldChangedEvent>((event, emit) {
      // Track form validity on each field change
      final isNameValid = event.name.isNotEmpty && event.name.length >= 3;
      final isEmailValid = event.email.isNotEmpty && event.email.contains('@');
      final isPasswordValid =
          event.password.isNotEmpty && event.password.length >= 6;

      if (isNameValid && isEmailValid && isPasswordValid) {
        emit(RegisterFormCompleteState()); // Form is valid, enable button
      } else {
        emit(RegisterInitial()); // Form is not valid, disable button
      }
    });
  }
}
