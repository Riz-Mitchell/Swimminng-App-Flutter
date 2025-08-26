import 'package:swimming_app_frontend/shared/infrastructure/api.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/user_entity.dart';

class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  Future<GetUserEntity> createUserAsync(CreateUserEntity schema) async {
    // Validate user data
    // if (!user.isComplete) throw Exception('User data is incomplete');

    try {
      // Call API to create user
      final res = await _apiClient.post('/api/User', data: schema.toJson());
      if (res == null) {
        throw Exception('Failed to create swim: No response from server.');
      }
      return GetUserEntity.fromJson(res.data);
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to create user: $e');
    }
  }

  Future<GetUserEntity> getUserAsync(String userId) async {
    try {
      // Call API to get user by ID
      final res = await _apiClient.get('/api/User/$userId');
      if (res == null) {
        throw Exception('Failed to create swim: No response from server.');
      }
      return GetUserEntity.fromJson(res.data);
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to get user: $e');
    }
  }

  Future<List<GetUserEntity>> queryUsersAsync(QueryUsersEntity schema) async {
    try {
      // Call API to get all users
      final res = await _apiClient.get('/api/User', query: schema.toJson());

      if (res == null) {
        throw Exception('Failed to create swim: No response from server.');
      }
      // Map response data to List<GetUserResDTO>
      return (res.data as List)
          .map((user) => GetUserEntity.fromJson(user))
          .toList();
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to get all users: $e');
    }
  }

  Future<void> deleteUserAsync(String userId) async {
    try {
      // Call API to delete user by ID
      await _apiClient.delete('/api/User/$userId');
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to delete user: $e');
    }
  }

  Future<GetUserEntity> updateUserAsync(
    String userId,
    UpdateUserEntity schema,
  ) async {
    try {
      // Call API to update user by ID
      final res = await _apiClient.put(
        '/api/User/$userId',
        data: schema.toJson(),
      );
      if (res == null) {
        throw Exception('Failed to create swim: No response from server.');
      }

      return GetUserEntity.fromJson(res.data);
    } catch (e) {
      // Handle error, e.g., show error message to user
      throw Exception('Failed to update user: $e');
    }
  }
}
