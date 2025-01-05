import 'dart:async';
import 'dart:convert';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/exception.dart';
import 'package:career_sphere/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiService extends BaseApiService {
  Dio dio = Dio();

  NetworkApiService()
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 100),
            receiveTimeout: const Duration(seconds: 100),
            headers: {
              "Content-Type": "application/json",
            },
          ),
        ) {
    // Add Interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          // Modify or log requests here
          // debugPrint("Request: ${options.method} ${options.uri}");
          // 1. Modify the request to add the Authorization header (JWT)
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // String? accessToken = prefs.getString("accessToken");
          String? accessToken =
              SharedPrefHelper.instance.getString('accessToken');
          debugPrint("AccessToken in Interceptor: $accessToken");
          // print('Request: ${options.method} ${options.uri}');
          if (accessToken != null && accessToken.isNotEmpty) {
            options.headers['Authorization'] = accessToken;
          } else {
            debugPrint("AccessToken is null or empty!");
          }
          handler.next(options); // Proceed with the request
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Log or modify the response
          debugPrint("Response: ${response.statusCode}");
          handler.next(response); // Proceed with the response
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          // Handle errors globally
          debugPrint("Error occurred: ${e.message}");
          if (e.response?.statusCode == 401) {
            _showAuthorizationErrorDialog();
          } else {
            return handler
                .reject(e); // Token refresh failed, reject the request
          }

          handleDioError(e); // Call your centralized error handling logic

          handler.next(e); // Pass the error to be handled downstream
        },
      ),
    );
  }

  // Keep a reference to the cancel token
  CancelToken? cancelToken;

  // For POST APIs
  @override
  Future postApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    cancelToken = CancelToken();
    try {
      debugPrint("Request URL: $url");
      debugPrint("Request Headers: ${""}"); // Log headers if any
      debugPrint("Request Payload: ${jsonEncode(data)}");
      Response response = await dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      responseJson = returnResponse(response);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint("Request canceled: ${e.message}");
      } else {
        handleDioError(e);
      }
    }
    return responseJson;
  }

  // Cancel the request
  void cancelRequest() {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel("Request canceled by user");
    }
  }

  @override
  Future<dynamic> getWithHeadersAndParams(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioError(e);
    }
  }

  // For GET APIs
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try {
      Response response = await dio.get(url);
      debugPrint(response.toString());
      responseJson = returnResponse(response);
    } on DioException catch (e) {
      handleDioError(e);
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data; // Dio automatically decodes JSON
    }
  }

  void handleDioError(DioException e) {
    if (e.response != null) {
      // Parse the error response
      final errorData = e.response?.data;

      // Handle HTTP status codes centrally
      switch (e.response!.statusCode) {
        case 400:
          throw ErrorResponseModel.fromJson(errorData); // Custom error model
        // throw FetchDataException(message: "Bad request (400)");
        case 401:
          throw FetchDataException(message: "Unauthorized (401)");
        case 404:
          throw ErrorResponseModel.fromJson(errorData);
        case 500:
        case 502:
        case 503:
          throw FetchDataException(
              message: "Server error (${e.response!.statusCode})");
        default:
          throw FetchDataException(message: "F");
        // "Unexpected error: ${e.response!.statusCode}, ${e.response!.data}");
      }
    }

    // Handle non-response errors
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw FetchDataException(message: "Request timed out");
    } else if (e.type == DioExceptionType.badCertificate) {
      throw FetchDataException(message: "Invalid SSL Certificate");
    } else if (e.type == DioExceptionType.connectionError) {
      throw FetchDataException(message: "No Internet Connection");
    } else if (e.type == DioExceptionType.unknown) {
      // Likely a malformed URL or DNS issue
      throw FetchDataException(
          message: "Unknown error - Possible invalid URL or server issue");
    } else if (CancelToken.isCancel(e)) {
      debugPrint("Request canceled: ${e.message}");
    } else {
      // throw FetchDataException(message: "Unexpected error: ${e.message}");
      throw FetchDataException(message: "Unexpected error:");
    }
  }

  void _showAuthorizationErrorDialog() async {
    // Retrieve SharedPreferences and clear them before using the context.
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.clear();

    SharedPrefHelper.instance.clearAllData();

    // final BuildContext context = navigatorKey.currentContext!;
    // Access the context safely via the navigatorKey.
    final navigatorState = navigatorKey.currentState;
    if (navigatorState != null && navigatorState.mounted) {
      showDialog(
        context: navigatorState.context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Session Expired'),
            content:
                const Text('Your session has expired. Please log in again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close the dialog
                  navigatorState.context
                      .go('/login'); //; // Navigate to the login page
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
