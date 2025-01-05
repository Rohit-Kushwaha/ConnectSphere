import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/login/model/req/req.dart';
import 'package:career_sphere/feature/login/model/res/login_model.dart';
import 'package:career_sphere/utils/strings.dart';
import 'package:flutter/material.dart';

abstract class LoginRepo {
  Future<BaseLoginResponse> login({required LoginRequestModel loginRequest});
}

class LoginRepoImpl extends LoginRepo {
  BaseApiService apiService = NetworkApiService();
  @override
  Future<BaseLoginResponse> login(
      {required LoginRequestModel loginRequest}) async {
    try {
      debugPrint("Repo 0");
      debugPrint(loginRequest.toJson().toString());
      

      var json = await apiService.postApiResponse(
          "https://ecommerce-lv31.onrender.com/user/login",
          loginRequest.toJson());
      debugPrint("${json}In repo");
      // Check if the user is verified or not
      if (json['isVerified'] == false) {
        // Handle the unverified user case (e.g., return a different model or data)
        return VerifiedFalseResponseModel.fromJson(
            json);
      }
       else {
        // Handle the verified user case
        return LoginModel.fromJson(
            json); // This returns the usual login model for verified users
      }
    } on ErrorResponseModel catch (error) {
      debugPrint('Error: ${error.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error in logging: $e');
      rethrow; // Let the Bloc handle this error
    }
  }
}
