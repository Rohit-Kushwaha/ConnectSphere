import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/otp/model/req/otp_send_req.dart';
import 'package:career_sphere/feature/otp/model/req/otp_verify_req.dart';
import 'package:career_sphere/feature/otp/model/res/otp_send_res.dart';
import 'package:career_sphere/feature/otp/model/res/otp_verify_res.dart';
import 'package:career_sphere/utils/strings.dart';
import 'package:flutter/material.dart';

abstract class OtpRepo {
  Future<OtpResponseModel> sendOtp({required OtpRequestModel otpRequestModel});
  Future<OtpVerifyResponseModel> verifyOtp(
      {required VerifyOtpRequestModel verifyOtpRequestModel});
}

class OtpRepoImpl extends OtpRepo {
  final BaseApiService apiService = NetworkApiService();

  @override
  Future<OtpResponseModel> sendOtp(
      {required OtpRequestModel otpRequestModel}) async {
    try {
      var json = await apiService.postApiResponse(
          ApiString.sendOtpUrl, otpRequestModel.toJson());

      return OtpResponseModel.fromJson(json);
    } on ErrorResponseModel catch (error) {
      // Handle parsed error response
      debugPrint('Error: ${error.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error in registerUser: $e');
      rethrow; // Let the Bloc handle this error
    }
  }

  @override
  Future<OtpVerifyResponseModel> verifyOtp(
      {required VerifyOtpRequestModel verifyOtpRequestModel}) async {
    try {
      var json = await apiService.postApiResponse(
          ApiString.verifyOtpUrl, verifyOtpRequestModel.toJson());

      return OtpVerifyResponseModel.fromJson(json);
    } on ErrorResponseModel catch (error) {
      // Handle parsed error response
      debugPrint('Error: ${error.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error in verifyOtp: $e');
      rethrow; // Let the Bloc handle this error
    }
  }
}
