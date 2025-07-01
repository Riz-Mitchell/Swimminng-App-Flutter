import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/core/storage.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = TokenStorage();
  return ApiClient(baseUrl: 'https://api.splashbookapp.com', storage: storage);
});

class ApiClient {
  final Dio _dio;
  final TokenStorage storage;

  ApiClient({required String baseUrl, required this.storage})
    : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
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
    return options.path.contains('/auth/refresh');
  }

  Future<void> _refreshTokens() async {
    final refreshToken = await storage.readRefresh();
    if (refreshToken == null) throw Exception('No refresh token');

    final resp = await _dio.post(
      '/auth/refresh',
      data: {'refresh_token': refreshToken},
    );

    final data = resp.data as Map<String, dynamic>;
    final access = data['access_token'] as String;
    final refresh = data['refresh_token'] as String;
    await storage.saveTokens(access: access, refresh: refresh);
  }

  // Convenience GET/POST/etc methods
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) {
    return _dio.get(path, queryParameters: query);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response<T>> put<T>(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response<T>> patch<T>(String path, {dynamic data}) {
    return _dio.patch(path, data: data);
  }

  Future<Response<T>> delete<T>(String path, {dynamic data}) {
    return _dio.delete(path, data: data);
  }

  // … put/patch/delete as needed
}
