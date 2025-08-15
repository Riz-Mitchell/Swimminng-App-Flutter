import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<AusApiClient>((ref) {
  final client = AusApiClient(
    baseUrl: 'https://sal-sc-results-prod-app.azurewebsites.net/api/public',
  );
  return client;
});

class AusApiClient {
  final Dio _dio;

  AusApiClient({required String baseUrl})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    // Optional: logging
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
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
}
