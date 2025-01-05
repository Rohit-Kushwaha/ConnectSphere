import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/home/profile/logout/model/res/logout_res.dart';
import 'package:career_sphere/utils/strings.dart';

abstract class LogRepo {
  Future<LogoutResponse> logout();
}

class LogOutRepoImpl extends LogRepo {
  BaseApiService apiService = NetworkApiService();

  @override
  Future<LogoutResponse> logout() async {
    var json = await apiService.getApiResponse(ApiString.logout);
    return LogoutResponse.fromJson(json);
  }
}
