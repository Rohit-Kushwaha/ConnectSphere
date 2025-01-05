abstract class BaseApiService {
  Future<dynamic> getApiResponse(String url);

  Future<dynamic> postApiResponse(String url, dynamic data);

  Future<dynamic> getWithHeadersAndParams(
    String url, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic>? headers,
  });
}
