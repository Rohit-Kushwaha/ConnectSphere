// import 'dart:async';
// import 'package:career_sphere/common/response/error_response.dart';
// import 'package:career_sphere/data/remote/network/base_api.dart';
// import 'package:career_sphere/data/remote/network/exception.dart';
// import 'package:career_sphere/utils/routes.dart';
// import 'package:career_sphere/utils/strings.dart';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class NetworkApiService extends BaseApiService {
//   Dio dio = Dio();

//   NetworkApiService()
//       : dio = Dio(
//           BaseOptions(
//             connectTimeout: const Duration(seconds: 100),
//             receiveTimeout: const Duration(seconds: 100),
//             headers: {
//               "Content-Type": "application/json",
//               // Default headers
//             },
//           ),
//         ) {
//     // Add Interceptors
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest:
//             (RequestOptions options, RequestInterceptorHandler handler) async {
//                // Modify or log requests here
//           // debugPrint("Request: ${options.method} ${options.uri}");
//           // 1. Modify the request to add the Authorization header (JWT)
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           String? accessToken = prefs.getString("accessToken");
//           debugPrint("AccessToken in Interceptor: $accessToken");
//           // print('Request: ${options.method} ${options.uri}');
//           if (accessToken != null && accessToken.isNotEmpty) {
//             options.headers['Authorization'] = accessToken;
//           } else {
//             debugPrint("AccessToken is null or empty!");
//           }
//           handler.next(options); // Proceed with the request
//         },
//         onResponse: (Response response, ResponseInterceptorHandler handler) {
//           debugPrint("Before Response");

//           // Log or modify the response
//           debugPrint("Response: ${response.statusCode} ${response.statusCode}");
//           handler.next(response); // Proceed with the response
//         },
//         onError: (DioException e, ErrorInterceptorHandler handler) async {
//           // Handle errors globally
//           debugPrint("Error occurred: ${e.message}");

//           // 3. If the token is expired (401 Unauthorized), attempt to refresh the token
//           if (e.response?.statusCode == 400) {
//             _showAuthorizationErrorDialog();

//             // try {
//             //   // Attempt to refresh the token
//             //   bool newToken = await refreshToken();
//             //   if (newToken) {
//             //     // Retry the original request with the new token
//             //     RequestOptions options = e.requestOptions;

//             //     final opts = e.requestOptions;
//             //     SharedPreferences prefs = await SharedPreferences.getInstance();
//             //     String? newAccessToken = prefs.getString("accessToken");

//             //     if (newAccessToken != null && newAccessToken.isNotEmpty) {
//             //       opts.headers['Authorization'] = newAccessToken;
//             //     }

//             //     final Response retryResponse = await _dio.fetch(opts);
//             //     return handler
//             //         .resolve(retryResponse); // Return the retried response
//             //     // options.headers['Authorization'] = 'Bearer $newToken';
//             //     // print("Retrying request with new token: ${options.uri}");
//             //     // Use Options, not RequestOptions, in the retry request
//             //     // Options retryOptions = Options(
//             //     //   headers: options.headers,
//             //     //   method: options.method,  // Retain the original request method (GET, POST, etc.)
//             //     //   contentType: options.contentType,
//             //     //   responseType: options.responseType,
//             //     // );
//             //     // try {
//             //     //   Response response = await _dio.request(
//             //     //     options.path,
//             //     //     cancelToken: options.cancelToken,
//             //     //     data: options.data,
//             //     //     options: retryOptions,  // Use the correct `Options` here
//             //     //     queryParameters: options.queryParameters,
//             //     //   );
//             //     //   return handler.resolve(response); // Return the new response
//             //     // } catch (_) {
//             //     //   return handler.reject(e); // If retry fails, reject the request
//             //     // }
//             //   }
//             // } catch (refreshError) {
//             //   // If token refresh fails, redirect to login
//             //   _showAuthorizationErrorDialog();
//             // }
//           }
//           // else {
//           //   return handler
//           //       .reject(e); // Token refresh failed, reject the request
//           // }

//           // handleDioError(e); // Call your centralized error handling logic

//           // handler.next(e); // Pass the error to be handled downstream
//         },
//       ),
//     );
//   }

//   // // SSL Pinning method
//   // Future<void> _configureSSLPinning() async {
//   //   try {
//   //     // Path to your certificate
//   //     String certPath = 'assets/certificates/your_cert.pem';

//   //     // Initialize SSL pinning
//   //     await SslPinningPlugin.setCertificate(
//   //       certPath, // This is the certificate you're pinning to
//   //       androidCertificateSha256: 'your_certificate_sha256_hash', // Optional if you want to pin SHA256 for Android
//   //       iosCertificateSha1: 'your_certificate_sha1_hash', // Optional for iOS pinning
//   //     );

//   //     // Add a custom `HttpClientAdapter` for Dio
//   //     _dio.httpClientAdapter = IOHttpClientAdapter()
//   //       ..onHttpClientCreate = (client) {
//   //         client.badCertificateCallback =
//   //             (X509Certificate cert, String host, int port) {
//   //           // Implement a check for the certificate
//   //           return cert.pem == certPath; // Customize this for your own logic
//   //         };
//   //       };

//   //     print("SSL Pinning configured successfully.");
//   //   } catch (e) {
//   //     print("Error configuring SSL Pinning: $e");
//   //   }
//   // }

//   // Keep a reference to the cancel token
//   CancelToken? cancelToken;

//   // For POST APIs
//   @override
//   Future postApiResponse(String url, dynamic data) async {
//     dynamic responseJson;
//     cancelToken = CancelToken();
//     try {
//       Response response = await dio.post(
//         url,
//         data: data,
//         cancelToken: cancelToken,
//       );
//       responseJson = returnResponse(response);
//     } on DioException catch (e) {
//       if (CancelToken.isCancel(e)) {
//         debugPrint("Request canceled: ${e.message}");
//       } else {
//         handleDioError(e);
//       }
//     }
//     return responseJson;
//   }

//   // Cancel the request
//   void cancelRequest() {
//     if (cancelToken != null && !cancelToken!.isCancelled) {
//       cancelToken!.cancel("Request canceled by user");
//     }
//   }
// //** Use in screen */
// //  @override
// //   void dispose() {
// //     // Cancel the API call when the widget is disposed
// //     NetworkApiService().cancelRequest();
// //     super.dispose();
// //   }

//   @override
//   Future<dynamic> getWithHeadersAndParams(
//     String url, {
//     Map<String, dynamic>? queryParameters,
//     Map<String, dynamic>? headers,
//   }) async {
//     try {
//       Response response = await dio.get(
//         url,
//         queryParameters: queryParameters,
//         options: Options(headers: headers),
//       );
//       return response.data;
//     } on DioException catch (e) {
//       handleDioError(e);
//     }
//   }

//   // For GET APIs
//   @override
//   Future getApiResponse(String url) async {
//     dynamic responseJson;
//     try {
//       Response response = await dio.get(url);
//       debugPrint(response.toString());
//       responseJson = returnResponse(response);
//     } on DioException catch (e) {
//       handleDioError(e);
//     }
//     return responseJson;
//   }

//   dynamic returnResponse(Response response) {
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         return response.data; // Dio automatically decodes JSON
//     }
//   }

//   void handleDioError(DioException e) {
//     if (e.response != null) {
//       // Parse the error response
//       final errorData = e.response?.data;
//       debugPrint('Error Response: $errorData');
//       // Handle specific status codes (e.g., 400 - Bad Request)

//       // Handle HTTP status codes centrally
//       switch (e.response!.statusCode) {
//         case 400:
//           throw ErrorResponseModel.fromJson(errorData); // Custom error model
//         // throw FetchDataException(message: "Bad request (400)");
//         case 401:
//           throw FetchDataException(message: "Unauthorized (401)");
//         case 404:
//           throw ErrorResponseModel.fromJson(errorData);
//         case 500:
//         case 502:
//         case 503:
//           throw FetchDataException(
//               message: "Server error (${e.response!.statusCode})");
//         default:
//           throw FetchDataException(message: "F");
//         // "Unexpected error: ${e.response!.statusCode}, ${e.response!.data}");
//       }
//     }

//     // Handle non-response errors
//     if (e.type == DioExceptionType.connectionTimeout ||
//         e.type == DioExceptionType.receiveTimeout) {
//       throw FetchDataException(message: "Request timed out");
//     } else if (e.type == DioExceptionType.badCertificate) {
//       throw FetchDataException(message: "Invalid SSL Certificate");
//     } else if (e.type == DioExceptionType.connectionError) {
//       throw FetchDataException(message: "No Internet Connection");
//     } else if (e.type == DioExceptionType.unknown) {
//       // Likely a malformed URL or DNS issue
//       throw FetchDataException(
//           message: "Unknown error - Possible invalid URL or server issue");
//     } else if (CancelToken.isCancel(e)) {
//       debugPrint("Request canceled: ${e.message}");
//     } else {
//       // throw FetchDataException(message: "Unexpected error: ${e.message}");
//       throw FetchDataException(message: "Unexpected error:");
//     }
//   }

//   void _showAuthorizationErrorDialog() {
//     // final BuildContext context = ConnectSphere.navigatorKey.currentContext!;
//     final BuildContext context = navigatorKey.currentContext!;

//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Session Expired'),
//           content: const Text('Your session has expired. Please log in again.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(); // Close the dialog
//                 context.go('/login'); //; // Navigate to the login page
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// Future<bool> refreshToken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? refreshToken = prefs.getString("refreshToken");

//   if (refreshToken == null || refreshToken.isEmpty) {
//     return false; // No refresh token available
//   }

//   try {
//     final response = await Dio().post(
//       "${ApiString.baseUrl}/user/refresh_token",
//       data: {'refreshToken': refreshToken},
//     );

//     if (response.statusCode == 200) {
//       // Save new tokens
//       String newAccessToken = response.data['accessToken'];
//       String newRefreshToken = response.data['refreshToken'];

//       await prefs.setString('accessToken', newAccessToken);
//       await prefs.setString('refreshToken', newRefreshToken);

//       return true; // Token refresh successful
//     } else {
//       return false; // Handle unexpected response
//     }
//   } catch (e) {
//     print("Refresh token error: $e");
//     return false;
//   }
// }
