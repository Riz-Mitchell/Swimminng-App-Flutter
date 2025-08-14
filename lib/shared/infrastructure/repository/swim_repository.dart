import 'package:dio/dio.dart';
import 'package:swimming_app_frontend/shared/infrastructure/api.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

class SwimRepository {
  final ApiClient _apiClient;

  SwimRepository(this._apiClient);

  Future<GetSwimEntity> createSwimReq(CreateSwimEntity schema) async {
    final res = await _apiClient.post('/api/Swim', data: schema.toJson());
    if (res == null) {
      throw Exception('Failed to create swim: No response from server.');
    }
    return GetSwimEntity.fromJson(res.data);
  }

  Future<GetSwimEntity> getSwimReq(String swimId) async {
    final res = await _apiClient.get('/api/Swim/$swimId');
    if (res == null) {
      throw Exception('Failed to get swim: No response from server.');
    }
    return GetSwimEntity.fromJson(res.data);
  }

  Future<List<GetSwimEntity>> getAllSwimsReq(QuerySwimEntity schema) async {
    try {
      final res = await _apiClient.get('/api/Swim', query: schema.toJson());
      if (res == null) {
        throw Exception('Failed to get all swims: No response from server.');
      }

      return (res.data as List)
          .map((swim) => GetSwimEntity.fromJson(swim))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      rethrow;
    }
  }

  // Future<GetSwimEntity> updateSwimReq(
  //   String swimId,
  //   UpdateSwimEntity schema,
  // ) async {
  //   try {
  //     final res = await _apiClient.put(
  //       '/api/Swim/$swimId',
  //       data: schema.toJson(),
  //     );
  //     if (res == null) {
  //       throw Exception('Failed to update swim: No response from server.');
  //     }
  //     return GetSwimEntity.fromJson(res.data);
  //   } catch (e) {
  //     throw Exception('Failed to update swim: $e');
  //   }
  // }

  Future<void> deleteSwimReq(String swimId) async {
    final client = await _apiClient;

    try {
      await client.delete('/api/Swim/$swimId');
    } catch (e) {
      throw Exception('Failed to delete swim: $e');
    }
  }
}
