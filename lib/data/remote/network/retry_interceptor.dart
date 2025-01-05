import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;

  RetryInterceptor({required this.dio, this.maxRetries = 3});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && err.requestOptions.extra['retries'] == null) {
      err.requestOptions.extra['retries'] = 0;
    }

    if (_shouldRetry(err) &&
        err.requestOptions.extra['retries'] < maxRetries) {
      print("Retrying request...");
      err.requestOptions.extra['retries'] += 1;

      try {
        // Retry the request
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        // Failed again; pass the error
        handler.next(e as DioException);
        return;
      }
    }

    // No retry; pass the error
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.response?.statusCode == 500;
  }
}
