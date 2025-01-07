abstract class BaseApiService {
  Future<dynamic> getApiResponse(String url);

  Future<dynamic> postApiResponse(String url, dynamic data);

  Future<dynamic> getWithParams(
    String url, {
    Map<String, dynamic> queryParameters,
  });
}
