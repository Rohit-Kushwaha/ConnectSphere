import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/feature/home/profile/logout/repo/logout_repo.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogRepo logRepo;
  LogoutBloc(this.logRepo) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) {});

    on<LogOutEvent>((event, emit) async {
      try {
        emit(LogoutWaitingState());
        await logRepo.logout();

        emit(LogoutSucess());
      } on ErrorResponseModel catch (error) {
        emit(LogoutFailedState(error: error.message));
      } catch (e) {
        emit(LogoutFailedState(error: "An unexpected error"));
      }
    });
  }
}
