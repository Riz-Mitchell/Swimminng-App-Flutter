import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/core/storage.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(baseUrl: 'https://api.inteliswim.com');
});

class ApiClient {
  final Dio _dio;
  PersistCookieJar? _cookieJar;

  ApiClient({required String baseUrl})
    : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => print('[DIO] $obj'),
      ),
    );

    if (!kIsWeb) {
      _initCookieJar(); // Only on mobile
    }

    /**
     * MIDDLEWARE TO ATTACH THE COOKIES
     */
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          final isUnauthorized = error.response?.statusCode == 401;
          bool isExceptionEndpoint = error.requestOptions.path.contains(
            '/api/Auth/refresh',
          );

          if (isUnauthorized && !isExceptionEndpoint) {
            try {
              print('[AUTH] Attempting token refresh...');

              bool refreshed = false;
              // attempt to get new tokens
              refreshed = await _attemptRefreshTokens();

              if (refreshed) {
                // Retry original request
                final retryResponse = await _dio.fetch(error.requestOptions);
                return handler.resolve(retryResponse);
              } else {
                print('[AUTH] Refresh failed — clearing session');
                if (!kIsWeb) await _cookieJar?.deleteAll();
                // optionally force logout or show dialog
              }
            } catch (e) {
              print('[AUTH] Refresh error: $e');
            }
          }

          return handler.next(error); // Give up, forward error
        },
        onResponse: (response, handler) async {
          if (!kIsWeb && _cookieJar != null) {
            final cookies = await _cookieJar!.loadForRequest(
              Uri.parse(_dio.options.baseUrl),
            );
            for (var cookie in cookies) {
              print(
                '[COOKIE] ${cookie.name} = ${cookie.value} was sent in above request',
              );
            }
          }

          return handler.next(response); // Continue the chain
        },
      ),
    );
  }

  Future<void> _initCookieJar() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = '${appDocDir.path}/.cookies';

    _cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));
    _dio.interceptors.add(CookieManager(_cookieJar!));
  }

  Future<bool> _attemptRefreshTokens() async {
    try {
      final response = await _dio.post('/api/Auth/refresh');
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> checkLoginStatus() async {
    if (kIsWeb || _cookieJar == null) return false;

    final uri = Uri.parse(_dio.options.baseUrl);
    final cookies = await _cookieJar!.loadForRequest(uri);

    final accessToken = findCookie('AccessToken', cookies);
    final refreshToken = findCookie('RefreshToken', cookies);

    if (accessToken == null || refreshToken == null) return false;
    if (accessToken.expires != null &&
        accessToken.expires!.isBefore(DateTime.now())) {
      print('[AUTH] AccessToken expired — trying refresh...');
      return await _attemptRefreshTokens(); // fallback to refresh
    }

    return true; // Token present and not expired
  }

  Cookie? findCookie(String name, List<Cookie> cookies) {
    for (var cookie in cookies) {
      if (cookie.name == name) return cookie;
    }
    return null;
  }

  Future<Response<T>?> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: query);
    } catch (e, stacktrace) {
      print('GET $path failed: $e');
      print(stacktrace);
      rethrow; // Optionally rethrow if you want upstream handling
    }
  }

  Future<Response<T>?> post<T>(String path, {dynamic data}) async {
    try {
      return await _dio.post<T>(path, data: data);
    } catch (e, stacktrace) {
      print('POST $path failed: $e');
      print(stacktrace);
      rethrow;
    }
  }

  Future<Response<T>?> put<T>(String path, {dynamic data}) async {
    try {
      return await _dio.put<T>(path, data: data);
    } catch (e, stacktrace) {
      print('PUT $path failed: $e');
      print(stacktrace);
      rethrow;
    }
  }

  Future<Response<T>?> patch<T>(String path, {dynamic data}) async {
    try {
      return await _dio.patch<T>(path, data: data);
    } catch (e, stacktrace) {
      print('PATCH $path failed: $e');
      print(stacktrace);
      rethrow;
    }
  }

  Future<Response<T>?> delete<T>(String path, {dynamic data}) async {
    try {
      return await _dio.delete<T>(path, data: data);
    } catch (e, stacktrace) {
      print('DELETE $path failed: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
