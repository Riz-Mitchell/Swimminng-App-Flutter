import 'package:dio/dio.dart';
import 'package:swimming_app_frontend/api/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<bool> verifyOTP(LoginReqDTO schema) async {
    try {
      // Call API to verify OTP and get tokens
      final res = await _apiClient.post(
        '/api/Auth/login',
        data: schema.toJson(),
      );

      print('res.data: ${res!.data}');

      return true;
    } catch (er) {
      return false;
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
}
