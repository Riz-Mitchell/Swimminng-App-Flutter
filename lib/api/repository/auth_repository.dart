import 'package:swimming_app_frontend/api/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final Ref _ref;

  AuthRepository(this._ref) : _apiClient = _ref.read(apiClientProvider);

  Future<void> generateOTP(OTPRequest schema) async {
    try {
      // Call API to generate OTP
      await _apiClient.post('/api/auth/generate-otp', data: schema.toJson());
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to generate OTP: $e');
    }
  }

  Future<void> verifyOTP(LoginRequest schema) async {
    try {
      // Call API to verify OTP
      await _apiClient.post('/api/auth/login', data: schema.toJson());
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to verify OTP: $e');
    }
  }
}
