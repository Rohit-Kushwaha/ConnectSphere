import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/home/items/model/req/item_res.dart';
import 'package:career_sphere/utils/strings.dart';

abstract class ItemsRepo {
  Future<ItemsResponse> getItems();
  Future<ItemsResponse> getItemsPage({int? limit });
}

class ItemsRepoImpl extends ItemsRepo {
  BaseApiService apiService = NetworkApiService();
  @override
  Future<ItemsResponse> getItems() async {
    var json = await apiService.getApiResponse(ApiString.getItems);
    return ItemsResponse.fromJson(json);
  }
  
  @override
  Future<ItemsResponse> getItemsPage({int? limit, int? page}) async{
    var json = await apiService.getWithParams(ApiString.getItems,queryParameters: {
      "limit": limit,
      "page" : page
    });
    return ItemsResponse.fromJson(json);
  }
}
