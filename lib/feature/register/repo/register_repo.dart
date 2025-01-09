import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/register/model/req/register_req.dart';
import 'package:career_sphere/feature/register/model/res/register_res.dart';
import 'package:career_sphere/utils/strings.dart';
import 'package:flutter/material.dart';

abstract class RegisterRepo {
  Future<RegisterModel> registerUser({
    required RegisterRequestModel requestModel,
  });
}

class RegisterRepoImpl extends RegisterRepo {
  BaseApiService apiServices = NetworkApiService();

  @override
  Future<RegisterModel> registerUser({
    required RegisterRequestModel requestModel,
  }) async {
    debugPrint("${requestModel.toJson()}Json Data");

    try {
      // Ensure the data structure matches your API expectations
      var json = await apiServices.postApiResponse(
          ApiString.registerUrl, requestModel.toJson());
      return RegisterModel.fromJson(json);
    } on ErrorResponseModel catch (error) {
      // Handle parsed error response
      debugPrint('Error: ${error.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error in registering User: $e');
      rethrow; // Let the Bloc handle this error
    }
  }
}
