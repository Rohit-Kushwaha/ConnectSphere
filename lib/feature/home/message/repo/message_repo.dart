import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/home/message/model/req/req.dart';
import 'package:career_sphere/feature/home/message/model/res/res.dart';
import 'package:career_sphere/utils/strings.dart';
import 'package:flutter/material.dart';

abstract class MessageRepo {
  Future<SearchResponseModel> searchUser(
      {required SearchRequestModel searchRequestModel});
}

class MessageRepoImpl extends MessageRepo {
  BaseApiService apiService = NetworkApiService();

  @override
  Future<SearchResponseModel> searchUser(
      {required SearchRequestModel searchRequestModel}) async {
    try {
      debugPrint(searchRequestModel.toJson().toString());
      var json = await apiService.postApiResponse(
          ApiString.searchUser, searchRequestModel.toJson());
      return SearchResponseModel.fromJson(json);
    } on ErrorResponseModel catch (error) {
      // Handle parsed error response
      debugPrint('Error: ${error.message}');
      rethrow;
    } catch (e) {
      debugPrint("Error in searching user $e");
      rethrow;
    }
  }
}
