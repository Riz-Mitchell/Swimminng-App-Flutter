import 'package:swimming_app_frontend/shared/infrastructure/api.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/auth_entity.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<bool> generateOTP(OtpEntity schema) async {
    // Call API to generate OTP
    try {
      final res = await _apiClient.post(
        '/api/Auth/generate-otp',
        data: schema.toJson(),
      );

      print('res.data: ${res!.data}');

      return true;
    } catch (er) {
      print(er);
      return false;
    }
  }

  Future<String?> verifyOTP(LoginEntity schema) async {
    try {
      final res = await _apiClient.post(
        '/api/Auth/login',
        data: schema.toJson(),
      );

      // Check if response and data exist
      if (res?.data == null || res!.data['userId'] == null) {
        print('[OTP] Missing userId in response');
        return null;
      }

      final String userId = res.data['userId'] as String;
      print('[OTP] Login successful, userId: $userId');

      return userId;
    } catch (e, st) {
      print('[OTP ERROR] $e');
      print('[STACK] $st');
      return null;
    }
  }

  Future<bool> checkLoginStatus() async {
    try {
      final loggedIn = await _apiClient.checkLoginStatus();
      print('loggedIn in repo: ${loggedIn}');
      return loggedIn;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAuthCookiesAsync() async {
    await _apiClient.clearCookies();
    return true;
  }

  Future<bool> logoutUserAsync(String userId) async {
    bool apiEndPointSuccess = false;

    try {
      final res = await _apiClient.post('/api/Auth/logout/$userId');
      apiEndPointSuccess = true;
    } catch (e) {
      print('Error calling logout API: $e');
      // Proceed to clear cookies even if logout API fails
    }

    return apiEndPointSuccess;
  }
}
