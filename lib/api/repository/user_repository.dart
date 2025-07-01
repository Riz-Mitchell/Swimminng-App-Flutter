import 'package:swimming_app_frontend/api/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';

class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  Future<GetUserResDTO> createUserReq(CreateUserReqDTO schema) async {
    // Validate user data
    // if (!user.isComplete) throw Exception('User data is incomplete');

    try {
      // Call API to create user
      final res = await _apiClient.post('/api/user', data: schema.toJson());

      return GetUserResDTO.fromJson(res.data);
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to create user: $e');
    }
  }

  Future<GetUserResDTO> getUserReq(String userId) async {
    try {
      // Call API to get user by ID
      final res = await _apiClient.get('/api/user/$userId');

      return GetUserResDTO.fromJson(res.data);
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to get user: $e');
    }
  }

  Future<List<GetUserResDTO>> getAllUsersReq(GetUsersQuery schema) async {
    try {
      // Call API to get all users
      final res = await _apiClient.get('/api/user', query: schema.toJson());

      // Map response data to List<GetUserResDTO>
      return (res.data as List)
          .map((user) => GetUserResDTO.fromJson(user))
          .toList();
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to get all users: $e');
    }
  }

  Future<void> deleteUserReq(String userId) async {
    try {
      // Call API to delete user by ID
      await _apiClient.delete('/api/user/$userId');
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to delete user: $e');
    }
  }

  Future<GetUserResDTO> updateUserReq(
    String userId,
    UpdateUserReqDTO schema,
  ) async {
    try {
      // Call API to update user by ID
      final res = await _apiClient.put(
        '/api/user/$userId',
        data: schema.toJson(),
      );

      return GetUserResDTO.fromJson(res.data);
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to update user: $e');
    }
  }

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
