import 'package:swimming_app_frontend/api/api.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<bool> generateOTP(OTPReqDTO schema) async {
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

  Future<String?> verifyOTP(LoginReqDTO schema) async {
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

  Future<bool> deleteCookiesAndAuthData(String userId) async {
    try {
      final res = await _apiClient.delete('/api/Auth/logout/$userId');

      print('logged out with status ${res!.statusCode}');
      return true;
    } catch (e) {
      return false;
    }
  }
}
