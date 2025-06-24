// import 'package:architect/services/AuthService.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'api_endpoint_urls.dart';
//
// class ApiClient {
//   static final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: "${APIEndpointUrls.baseUrl}",
//       connectTimeout: const Duration(seconds: 60),
//       receiveTimeout: const Duration(seconds: 60),
//       headers: {"Content-Type": "application/json"},
//     ),
//   );
//
//   static const List<String> _unauthenticatedEndpoints = [
//     '/api/login-otp',
//     '/api/company/register',
//     '/api/refreshtoken',
//     '/api/get-architect-by-id',
//     '/api/create-post',
//     '/api/company/verify-otp',
//     '/api/verify-login-otp',
//     '/api/resend-login-otp',
//     '/api/states',
//     '/api/get-architects',
//     '/api/plans',
//     '/api/company/resend-otp',
//   ];
//
//   // static void setupInterceptors() {
//   //   _dio.interceptors.add(
//   //     InterceptorsWrapper(
//   //       onRequest: (options, handler) async {
//   //         debugPrint('Interceptor triggered for: ${options.uri}');
//   //
//   //         final isUnauthenticated = _unauthenticatedEndpoints.any(
//   //           (endpoint) => options.uri.path.startsWith(endpoint),
//   //         );
//   //
//   //         if (isUnauthenticated) {
//   //           debugPrint(
//   //             'Unauthenticated endpoint, skipping token check: ${options.uri}',
//   //           );
//   //           return handler.next(options); // Skip token check
//   //         }
//   //
//   //         // Get access token from storage
//   //         final accessToken = await AuthService.getAccessToken();
//   //
//   //         if (accessToken == null || accessToken.isEmpty) {
//   //           debugPrint('❌ No access token found');
//   //         } else {
//   //           // Attach token to request headers
//   //           options.headers['Authorization'] = 'Bearer $accessToken';
//   //           debugPrint('✅ Access token added to headers');
//   //         }
//   //
//   //         return handler.next(options);
//   //       },
//   //
//   //       onResponse: (response, handler) async {
//   //         // Check if response data signals token expired
//   //         if (response.data is Map<String, dynamic>) {
//   //           final data = response.data as Map<String, dynamic>;
//   //           if (data['status'] == false &&
//   //               data['message'] == 'Token is expired') {
//   //             debugPrint('Token expired detected in interceptor response');
//   //
//   //             await AuthService.logout();
//   //
//   //             return handler.reject(
//   //               DioException(
//   //                 requestOptions: response.requestOptions,
//   //                 error: 'Token expired',
//   //                 response: response,
//   //               ),
//   //             );
//   //           }
//   //         }
//   //
//   //         return handler.next(response);
//   //       },
//   //
//   //       onError: (DioException e, handler) async {
//   //         // Check if the request is for an unauthenticated endpoint
//   //         final isUnauthenticated = _unauthenticatedEndpoints.any(
//   //           (endpoint) => e.requestOptions.uri.path.endsWith(endpoint),
//   //         );
//   //         if (isUnauthenticated) {
//   //           debugPrint(
//   //             'Unauthenticated endpoint error, skipping logout: ${e.requestOptions.uri}',
//   //           );
//   //           return handler.next(e); // Skip logout for unauthenticated endpoints
//   //         }
//   //
//   //         return handler.next(e); // Pass other errors to the next interceptor
//   //       },
//   //     ),
//   //   );
//   // }
//   static void setupInterceptors() {
//     try {
//       logger.d("[UserApi] Setting up interceptors... NavigatorKey: $navigatorKey");
//       _dio.interceptors.clear();
//       _configureSslPinning();
//
//       _dio.interceptors.add(LogInterceptor(
//         request: kDebugMode,
//         requestHeader: kDebugMode,
//         requestBody: kDebugMode,
//         responseHeader: kDebugMode,
//         responseBody: kDebugMode,
//         error: true,
//       ));
//
//       _dio.interceptors.add(InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           logger.d('[Interceptor] Triggered for: ${options.uri}');
//
//           final isUnauthenticated = _unauthenticatedEndpoints.any(
//                 (endpoint) => options.uri.path.startsWith(endpoint),
//           );
//
//           if (isUnauthenticated) {
//             logger.d('[Interceptor] Unauthenticated endpoint: ${options.uri}');
//             return handler.next(options);
//           }
//
//           // Check token expiration
//           final isExpired = await AuthService.isTokenExpired();
//           logger.d('[Interceptor] Token expired: $isExpired');
//
//           if (isExpired) {
//             logger.d('[Interceptor] Token expired, attempting refresh...');
//             await AuthService.logout();
//           }
//
//           // Add Authorization header
//           final accessToken = await AuthService.getAccessToken();
//           logger.d('[Interceptor] Access token: $accessToken');
//           if (accessToken != null && accessToken.isNotEmpty) {
//             options.headers['Authorization'] = 'Bearer $accessToken';
//           } else {
//             logger.e('❌ No access token, logging out');
//             await AuthService.logout();
//             return handler.reject(
//               DioException(
//                 requestOptions: options,
//                 error: 'No access token, please log in again',
//                 type: DioExceptionType.cancel,
//               ),
//             );
//           }
//
//           return handler.next(options);
//         },
//
//         onResponse: (response, handler) {
//           logger.d('[Interceptor] ✅ Response: ${response.statusCode} from ${response.requestOptions.uri}');
//           _handleNavigation(response.statusCode, navigatorKey);
//           return handler.next(response);
//         },
//
//         onError: (DioException e, handler) async {
//           final isUnauthenticated = _unauthenticatedEndpoints.any(
//                 (endpoint) => e.requestOptions.uri.path.endsWith(endpoint),
//           );
//
//           if (isUnauthenticated) {
//             logger.w('[Interceptor] Error on unauthenticated endpoint: ${e.requestOptions.uri}');
//             return handler.next(e);
//           }
//
//           if (e.response?.statusCode == 401) {
//             logger.e('❌ Unauthorized (401), logging out user');
//             await AuthService.logout();
//             return handler.reject(
//               DioException(
//                 requestOptions: e.requestOptions,
//                 error: 'Unauthorized, please log in again',
//                 type: DioExceptionType.badResponse,
//                 response: e.response,
//               ),
//             );
//           }
//
//           logger.e('[Interceptor] ❌ Dio Error: ${e.message}');
//           return handler.next(e);
//         },
//       ));
//
//       logger.d("[UserApi] Interceptors successfully set: ${_dio.interceptors.length}");
//     } catch (e, stackTrace) {
//       logger.e("[UserApi] Error setting up interceptors: $e");
//       logger.e("[UserApi] Stack trace: $stackTrace");
//     }
//   }
//
//   static Future<Response> get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     bool auth = true,
//   }) async {
//     if (!auth) {
//       final dio = Dio(BaseOptions(baseUrl: APIEndpointUrls.baseUrl));
//       return dio.get(path, queryParameters: queryParameters);
//     }
//     return _dio.get(path, queryParameters: queryParameters);
//   }
//
//   static Future<Response> post(String path, {dynamic data}) async {
//     try {
//       return await _dio.post(path, data: data);
//     } catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   static Future<Response> put(String path, {dynamic data}) async {
//     try {
//       return await _dio.put(path, data: data);
//     } catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   static Future<Response> delete(String path) async {
//     try {
//       return await _dio.delete(path);
//     } catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   static Response _handleError(dynamic error) {
//     if (error is DioException) {
//       print("DioException occurred: ${error.message}");
//       throw error;
//     } else {
//       print("Unexpected error: $error");
//       throw Exception("Unexpected error occurred");
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:architect/services/AuthService.dart';
import 'package:architect/services/api_endpoint_urls.dart';
import 'package:architect/app_routes/router.dart';

class ApiClient {
  static final Logger logger = Logger();
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "${APIEndpointUrls.baseUrl}",
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {"Content-Type": "application/json"},
    ),
  );

  static const List<String> _unauthenticatedEndpoints = [
    '/api/login-otp',
    '/api/company/register',
    '/api/refreshtoken',
    '/api/get-architect-by-id',
    '/api/create-post',
    '/api/company/verify-otp',
    '/api/verify-login-otp',
    '/api/resend-login-otp',
    '/api/states',
    '/api/get-architects',
    '/api/plans',
    '/api/company/resend-otp',
    '/api/company/additional-info',
  ];

  static void setupInterceptors() {
    try {
      logger.d(
        "[ApiClient] Setting up interceptors... NavigatorKey: $navigatorKey",
      );
      _dio.interceptors.clear();


      _dio.interceptors.add(
        LogInterceptor(
          request: kDebugMode,
          requestHeader: kDebugMode,
          requestBody: kDebugMode,
          responseHeader: kDebugMode,
          responseBody: kDebugMode,
          error: true,
        ),
      );

      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            logger.d('[Interceptor] Triggered for: ${options.uri}');

            final isUnauthenticated = _unauthenticatedEndpoints.any(
              (endpoint) => options.uri.path.startsWith(endpoint),
            );

            if (isUnauthenticated) {
              logger.d(
                '[Interceptor] Unauthenticated endpoint: ${options.uri}',
              );
              return handler.next(options);
            }

            // Check token expiration
            final isExpired = await AuthService.isTokenExpired();
            logger.d('[Interceptor] Token expired: $isExpired');

            if (isExpired) {
              logger.d('[Interceptor] Token expired, attempting logout...');
              await AuthService.logout();
              return handler.reject(
                DioException(
                  requestOptions: options,
                  error: 'Token expired, please log in again',
                  type: DioExceptionType.cancel,
                ),
              );
            }

            // Get access token from storage
            final accessToken = await AuthService.getAccessToken();
            logger.d('[Interceptor] Access token: $accessToken');

            if (accessToken == null || accessToken.isEmpty) {
              logger.e('❌ No access token, logging out');
              await AuthService.logout();
              return handler.reject(
                DioException(
                  requestOptions: options,
                  error: 'No access token, please log in again',
                  type: DioExceptionType.cancel,
                ),
              );
            } else {
              options.headers['Authorization'] = 'Bearer $accessToken';
              logger.d('✅ Access token added to headers');
            }

            return handler.next(options);
          },

          onResponse: (response, handler) async {
            logger.d(
              '[Interceptor] ✅ Response: ${response.statusCode} from ${response.requestOptions.uri}',
            );

            // Check if response data signals token expired
            if (response.data is Map<String, dynamic>) {
              final data = response.data as Map<String, dynamic>;
              if (data['status'] == false &&
                  data['message'] == 'Token is expired') {
                logger.d('Token expired detected in interceptor response');
                await AuthService.logout();
                return handler.reject(
                  DioException(
                    requestOptions: response.requestOptions,
                    error: 'Token expired',
                    response: response,
                    type: DioExceptionType.badResponse,
                  ),
                );
              }
            }

            _handleNavigation(response.statusCode, navigatorKey);
            return handler.next(response);
          },

          onError: (DioException e, handler) async {
            final isUnauthenticated = _unauthenticatedEndpoints.any(
              (endpoint) => e.requestOptions.uri.path.endsWith(endpoint),
            );

            if (isUnauthenticated) {
              logger.w(
                '[Interceptor] Error on unauthenticated endpoint: ${e.requestOptions.uri}',
              );
              return handler.next(e);
            }

            if (e.response?.statusCode == 401) {
              logger.e('❌ Unauthorized (401), logging out user');
              await AuthService.logout();
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,
                  error: 'Unauthorized, please log in again',
                  type: DioExceptionType.badResponse,
                  response: e.response,
                ),
              );
            }

            logger.e('[Interceptor] ❌ Dio Error: ${e.message}');
            return handler.next(e);
          },
        ),
      );

      logger.d(
        "[ApiClient] Interceptors successfully set: ${_dio.interceptors.length}",
      );
    } catch (e, stackTrace) {
      logger.e("[ApiClient] Error setting up interceptors: $e");
      logger.e("[ApiClient] Stack trace: $stackTrace");
    }
  }

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print("called get method");
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Response _handleError(dynamic error) {
    if (error is DioException) {
      logger.e("DioException occurred: ${error.message}");
      throw error;
    } else {
      logger.e("Unexpected error: $error");
      throw Exception("Unexpected error occurred");
    }
  }

  // Placeholder for _handleNavigation (implement as needed)
  static void _handleNavigation(
    int? statusCode,
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    logger.d("[ApiClient] Handling navigation for status code: $statusCode");

  }
}
