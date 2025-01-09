import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/feature/otp/model/req/otp_send_req.dart';
import 'package:career_sphere/feature/otp/model/req/otp_verify_req.dart';
import 'package:career_sphere/feature/otp/model/res/otp_verify_res.dart';
import 'package:career_sphere/feature/otp/repo/otp_repo.dart';
import 'package:equatable/equatable.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepo otpRepo;
  OtpBloc(this.otpRepo) : super(OtpInitial()) {
    on<OtpEvent>((event, emit) {});

    on<AutomaticOtpSentEvent>((event, emit) async {
      try {
        emit(OtpSendingState());
        // Create a request model

        final otpRequestModel = OtpRequestModel(
          email: event.email,
        );

        final otpData = await otpRepo.sendOtp(otpRequestModel: otpRequestModel);
        emit(OtpSendState(message: otpData.otp));
      } on ErrorResponseModel catch (error) {
        emit(OtpErrorState(error: error.message));
      } catch (e) {
        emit(OtpErrorState(error: "An unexpected error occurred"));
      }
    });

    on<ResendOtpSentEvent>((event, emit) async {
      try {
        emit(OtpSendingState());
        // Create a request model

        final otpRequestModel = OtpRequestModel(
          email: event.email,
        );

        final otpData = await otpRepo.sendOtp(otpRequestModel: otpRequestModel);
        emit(OtpSendState(message: otpData.otp));
      } on ErrorResponseModel catch (error) {
        emit(OtpErrorState(error: error.message));
      } catch (e) {
        emit(OtpErrorState(error: "An unexpected error occurred"));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(OtpCheckingState());
      try {
        final verifyOtpRequestModel = VerifyOtpRequestModel(
          email: event.email,
          otp: event.otp,
        );
        final OtpVerifyResponseModel userData = await otpRepo.verifyOtp(
            verifyOtpRequestModel: verifyOtpRequestModel);
        await SharedPrefHelper.instance
            .saveData('accessToken', userData.accessToken);
        await SharedPrefHelper.instance.saveData('senderID', userData.id);

        emit(OtpVerifiedState());
      } on ErrorResponseModel catch (error) {
        emit(OtpErrorState(error: error.message));
      } catch (e) {
        emit(OtpErrorState(error: "An unexpected error occurred"));
      }
    });
  }
}
