import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/core/storage.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = TokenStorage();
  return ApiClient(baseUrl: 'https://api.splashbookapp.com', storage: storage);
});

class ApiClient {
  final Dio _dio;
  final TokenStorage storage;
  final CookieJar _cookieJar;

  ApiClient({required String baseUrl, required this.storage})
    : _dio = Dio(BaseOptions(baseUrl: baseUrl)),
      _cookieJar = CookieJar() {
    _dio.interceptors.add(CookieManager(_cookieJar));
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.readAccess();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          debugPrint('--- REQUEST DEBUG ---');
          debugPrint('URI: ${options.uri}');
          debugPrint('Headers: ${options.headers}');
          debugPrint('Method: ${options.method}');
          debugPrint('Data: ${options.data}');
          debugPrint('----------------------');

          return handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (obj) => print('[DIO] $obj'), // Optional: custom logger
      ),
    );
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          // 1) Attach access token
          final token = await storage.readAccess();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // 2) If 401, try to refresh and retry once
          if (error.response?.statusCode == 401 &&
              !_isRefreshEndpoint(error.requestOptions)) {
            try {
              await _refreshTokens();
              final opts = error.requestOptions;
              final newToken = await storage.readAccess();
              if (newToken != null) {
                opts.headers['Authorization'] = 'Bearer $newToken';
              }
              // retry original request
              final cloneReq = await _dio.fetch(opts);
              return handler.resolve(cloneReq);
            } catch (e) {
              // refresh failed — clear and forward error
              await storage.clear();
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  bool _isRefreshEndpoint(RequestOptions options) {
    return options.path.contains('api/Auth/refresh');
  }

  Future<void> _refreshTokens() async {
    final refreshToken = await storage.readRefresh();
    if (refreshToken == null) throw Exception('No refresh token');

    final resp = await _dio.post(
      '/api/Auth/refresh',
      data: {'refresh_token': refreshToken},
    );

    final data = resp.data as Map<String, dynamic>;
    final access = data['access_token'] as String;
    final refresh = data['refresh_token'] as String;
    await storage.saveTokens(access: access, refresh: refresh);
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
