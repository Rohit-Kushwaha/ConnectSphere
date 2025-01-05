import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/home/message/chat/model/req/chat_req.dart';
import 'package:career_sphere/feature/home/message/chat/model/res/chat_res.dart';
import 'package:career_sphere/utils/strings.dart';
import 'package:flutter/material.dart';

abstract class ChatRepo {
  Future<ChatResponseModel> getMessage(
      {required ChatRequestModel chatRequestModel});
}

class ChatRepoImpl extends ChatRepo {
  BaseApiService apiService = NetworkApiService();

  @override
  Future<ChatResponseModel> getMessage(
      {required ChatRequestModel chatRequestModel}) async {
    try {
      var json = await apiService.postApiResponse(
          ApiString.getMessage, chatRequestModel.toJson());
      return ChatResponseModel.fromJson(json);
    } on ErrorResponseModel catch (error) {
      debugPrint("Error in error response $error");
      rethrow;
    } catch (e) {
      debugPrint("Error in getting message $e");
      rethrow;
    }
  }
}
