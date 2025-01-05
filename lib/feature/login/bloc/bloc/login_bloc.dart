import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/feature/login/model/req/req.dart';
import 'package:career_sphere/feature/login/model/res/login_model.dart';
import 'package:career_sphere/feature/login/repo/login_repo.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepo loginRepo;
  LoginBloc(this.loginRepo) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    on<CheckPasswordEvent>((event, emit) {
      emit(PasswordCheckState(isVisible: !event.isVisible));
    });

    on<LoginUserEvent>((event, emit) async {
      if (!event.email.contains('@')) {
        return emit(UserLoginErrorState(error: "Invalid email"));
      }
      if (event.password.length < 6) {
        return emit(
          UserLoginErrorState(error: "Password must be at least 6 characters"),
        );
      }

      try {
        emit(UserLoadingState());

        final requestModel = LoginRequestModel(
          email: event.email,
          password: event.password,
        );

        var userData = await loginRepo.login(loginRequest: requestModel);

        if (userData is LoginModel) {
          // Access the accessToken if it's a LoginModel
          await SharedPrefHelper.instance
              .saveData('accessToken', userData.accessToken);

          return emit(UserLoggedInState());
        } else if (userData is VerifiedFalseResponseModel) {
          return emit(UserNotVerifiedState());
        }
      } on ErrorResponseModel catch (error) {
        emit(UserLoginErrorState(error: error.message));
      } catch (e) {
        emit(UserLoginErrorState(error: "An unexpected error"));
      }
    });
  }
}
