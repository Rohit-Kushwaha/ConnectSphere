import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/home/places/model/res/places_model.dart';
// import 'package:career_sphere/utils/strings.dart';
import 'package:flutter/material.dart';

abstract class PlacesRepo {
  Future<PlaceResponseModel> getPlaces({required int page});
}

class PlacesRepoImpl extends PlacesRepo {
  BaseApiService apiServices = NetworkApiService();

  @override
  Future<PlaceResponseModel> getPlaces({required int page}) async {
    try {
      print("APi hit");
      var json = await apiServices.getApiResponse(
          "https://ecommerce-lv31.onrender.com/api/places");
      return PlaceResponseModel.fromJson(json);
    } on ErrorResponseModel catch (error) {
      debugPrint('Error: ${error.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error in getting Places: $e');
      rethrow; // Let the Bloc handle this error
    }
  }
}
