import 'package:dio/dio.dart';
import 'package:swimming_app_frontend/api/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<Response> generateOTP(OTPRequest schema) async {
    // Call API to generate OTP
    final res = await _apiClient.post(
      '/api/Auth/generate-otp',
      data: schema.toJson(),
    );
    if (res == null) {
      throw Exception('Failed to generate OTP: No response from server.');
    }

    print('res.data: ${res.data}');
    return res;
  }

  Future<Response> verifyOTP(LoginRequest schema) async {
    try {
      // Call API to verify OTP and get tokens
      final response = await _apiClient.post(
        '/api/Auth/login',
        data: schema.toJson(),
      );

      if (response == null) {
        throw Exception('Failed to verify OTP: No response from server.');
      }

      final data = response.data as Map<String, dynamic>;
      final access = data['access_token'] as String;
      final refresh = data['refresh_token'] as String;

      // Save tokens using storage
      await _apiClient.storage.saveTokens(access: access, refresh: refresh);
      print('Access token: $access');
      print('Refresh token: $refresh');
      return response;
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to verify OTP: $e');
    }
  }
}
