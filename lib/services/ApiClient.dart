import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    '/api/create-post',
    '/api/company/verify-otp',
    '/api/verify-login-otp',
    '/api/resend-login-otp',
    '/api/states',
    '/api/get-architects',
    '/api/plans',
    '/api/company/resend-otp',
    '/api/company/additional-info',
    '/api/create-payment',
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

            // final isUnauthenticated = _unauthenticatedEndpoints.any(
            //       (endpoint) => options.uri.path == endpoint,
            // );

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
