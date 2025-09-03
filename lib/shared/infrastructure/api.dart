import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/application/providers/auth_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/storage_provider.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient(baseUrl: 'https://api.inteliswim.com', ref: ref);
  return client;
});

class ApiClient {
  final Dio _dio;
  final Ref ref;
  bool _initialized = false;
  PersistCookieJar? _cookieJar;

  ApiClient({required String baseUrl, required this.ref})
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
    /**
     * MIDDLEWARE TO ATTACH THE COOKIES
     */
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          final statusCode = error.response?.statusCode;
          final isUnauthorized = statusCode == 401;
          final isRefreshEndpoint = error.requestOptions.path.contains(
            '/api/Auth/refresh',
          );
          final exceptionEndpoints = [
            '/api/Auth/login',
            '/api/Auth/generate-otp',
            '/api/Auth/signup',
          ];

          final isLogoutEndpoint = error.requestOptions.path.contains(
            '/api/Auth/logout',
          );

          if (isLogoutEndpoint) {
            print(
              '401 received from logout endpoint, skipping refresh and logout call',
            );
            // Resolve gracefully to prevent retry/loop
            return handler.resolve(
              Response(
                requestOptions: error.requestOptions,
                statusCode: error.response?.statusCode ?? 401,
                data: error.response?.data ?? {'message': 'Logout ignored.'},
              ),
            );
          }

          final isExceptionEndpoint = exceptionEndpoints.any(
            (endpoint) => error.requestOptions.path.contains(endpoint),
          );

          final isCreateUserEndpoint = error.requestOptions.path.contains(
            '/api/User',
          );

          print(
            'Error intercepted with method ${error.requestOptions.method} at ${error.requestOptions.path}',
          );

          if (error.requestOptions.method == 'POST' && isCreateUserEndpoint) {
            print(
              '[AUTH] 401 received from create user endpoint, likely due to duplicate phone number',
            );
            return handler.next(error);
          } else {
            print('Not a create user endpoint');
          }

          if (isExceptionEndpoint) {
            // Do not attempt refresh on these endpoints and don't logout
            print(
              '[AUTH] 401 received from exception endpoint: ${error.requestOptions.path}',
            );
            return handler.next(error);
          }

          print('INSIDE DIO INTERCEPTOR');

          if (isUnauthorized) {
            print(
              '[AUTH] 401 Unauthorized received from ${error.requestOptions.path}',
            );
          }

          if (isRefreshEndpoint) {
            print(
              '[AUTH] 401 received from refresh endpoint, likely invalid refresh token',
            );
          }

          if (isUnauthorized && !isRefreshEndpoint && !isExceptionEndpoint) {
            try {
              print('[AUTH] Attempting token refresh...');
              final refreshed = await _attemptRefreshTokens();

              if (refreshed) {
                print('[AUTH] Refresh successful, retrying original request');
                final retryResponse = await _dio.fetch(error.requestOptions);
                return handler.resolve(retryResponse);
              } else {
                // Refresh failed → force logout
                print('[AUTH] Refresh failed — logging out');
                if (!kIsWeb) await _cookieJar?.deleteAll();

                // ✅ Logout via Riverpod controller
                await ref.read(authControllerProvider.notifier).logout();

                // Optional: return a controlled error to the original API call
                return handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    response: error.response,
                    type: DioExceptionType.badResponse,
                    error: 'Session expired, logged out',
                  ),
                );
              }
            } catch (e, st) {
              // Catch unexpected errors during refresh → also logout
              print('[AUTH] Unexpected refresh error: $e');
              await ref.read(authControllerProvider.notifier).logout();
              return handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  response: error.response,
                  type: DioExceptionType.badResponse,
                  error: 'Session expired, logged out',
                ),
              );
            }
          } else {
            print('[AUTH] Error not handled by interceptor: $error');
            try {
              await ref.read(authControllerProvider.notifier).logout();
              return handler.reject(error);
            } catch (e) {
              print('Error during logout inside of api client: $e');
              return handler.reject(error);
            }
          }
        },
        onResponse: (response, handler) async {
          if (!kIsWeb && _cookieJar != null) {
            final cookies = await _cookieJar!.loadForRequest(
              Uri.parse(_dio.options.baseUrl),
            );
            if (cookies.isEmpty) {
              print('[COOKIE] No cookies were set in the response');
            }
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

  Future<void> init() async {
    if (_initialized) return;

    if (kIsWeb) return;

    print('initialising cookie jar');
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = '${appDocDir.path}/.cookies';

    _cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

    final uri = Uri.parse(_dio.options.baseUrl);
    final cookies = await _cookieJar!.loadForRequest(uri);

    final accessToken = findCookie('AccessToken', cookies);
    final refreshToken = findCookie('RefreshToken', cookies);

    if (accessToken != null) print('access token found');
    if (refreshToken != null) print('refreshtoken found');

    _dio.interceptors.add(CookieManager(_cookieJar!));

    _initialized = true;
  }

  Future<bool> _attemptRefreshTokens() async {
    print('inside attempt refresh tokens function');

    final storage = await ref.read(storageProvider.future);
    final userId = storage.userId;
    if (userId == null) return false;

    try {
      final response = await _dio.post(
        '/api/Auth/refresh/$userId',
        options: Options(
          validateStatus: (status) => true, // Accept all status codes
        ),
      );

      if (response.statusCode == 200) {
        print('Refresh succeeded');
        return true;
      } else {
        print('Refresh failed: ${response.statusCode}');
        return false;
      }
    } catch (e, st) {
      print('Unexpected error in refresh tokens: $e');
      return false;
    }
  }

  Future<bool> checkLoginStatus() async {
    await init();

    if (kIsWeb || _cookieJar == null) {
      print('either web or cookiJar null');
      if (_cookieJar == null) {
        print('cookie jar null');
      }
      return false;
    }

    final uri = Uri.parse(_dio.options.baseUrl);
    final cookies = await _cookieJar!.loadForRequest(uri);

    final accessToken = findCookie('AccessToken', cookies);
    final refreshToken = findCookie('RefreshToken', cookies);

    if (accessToken == null || refreshToken == null) {
      print('returning false tokens not found');
      return false;
    }
    // if (accessToken.expires != null &&
    //     accessToken.expires!.isBefore(DateTime.now())) {
    //   print('[AUTH] AccessToken expired — trying refresh...');
    //   return await _attemptRefreshTokens(); // fallback to refresh
    // }

    print('check login status returning true');
    return true; // Token present and not expired
  }

  Cookie? findCookie(String name, List<Cookie> cookies) {
    for (var cookie in cookies) {
      if (cookie.name == name) return cookie;
    }
    return null;
  }

  Future<void> clearCookies() async {
    await init();

    if (!kIsWeb && _cookieJar != null) {
      print('[AUTH] Clearing cookies');
      await _cookieJar!.deleteAll();
    }
  }

  Future<Response<T>?> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    await init();

    try {
      return await _dio.get<T>(path, queryParameters: query);
    } catch (e, stacktrace) {
      print('GET $path failed: $e');
      print(stacktrace);
      rethrow; // Optionally rethrow if you want upstream handling
    }
  }

  Future<Response<T>?> post<T>(
    String path, {
    dynamic data,
    bool skipInterceptor = false,
  }) async {
    await init();

    try {
      print('inside post method of api client');
      final res = await _dio.post<T>(
        path,
        data: data,
        options: Options(extra: {'skipInterceptor': skipInterceptor}),
      );
      print('after post call in api client');
      return res;
    } catch (e, stacktrace) {
      print('POST $path failed: $e');
      print(stacktrace);
      rethrow;
    }
  }

  Future<Response<T>?> put<T>(String path, {dynamic data}) async {
    await init();

    try {
      return await _dio.put<T>(path, data: data);
    } catch (e, stacktrace) {
      print('PUT $path failed: $e');
      print(stacktrace);
      rethrow;
    }
  }

  Future<Response<T>?> patch<T>(String path, {dynamic data}) async {
    await init();

    try {
      return await _dio.patch<T>(path, data: data);
    } catch (e, stacktrace) {
      print('PATCH $path failed: $e');
      print(stacktrace);
      rethrow;
    }
  }

  Future<Response<T>?> delete<T>(String path, {dynamic data}) async {
    await init();

    try {
      return await _dio.delete<T>(path, data: data);
    } catch (e, stacktrace) {
      print('DELETE $path failed: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
