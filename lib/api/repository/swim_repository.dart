import 'package:dio/dio.dart';
import 'package:swimming_app_frontend/api/api.dart';
import 'package:swimming_app_frontend/features/swims/infrastructure/models/swim_model.dart';

class SwimRepository {
  final ApiClient _apiClient;

  SwimRepository(this._apiClient);

  Future<GetSwimResDTO> createSwimReq(CreateSwimReqDTO schema) async {
    final res = await _apiClient.post('/api/Swim', data: schema.toJson());
    if (res == null) {
      throw Exception('Failed to create swim: No response from server.');
    }
    return GetSwimResDTO.fromJson(res.data);
  }

  Future<GetSwimResDTO> getSwimReq(String swimId) async {
    final res = await _apiClient.get('/api/Swim/$swimId');
    if (res == null) {
      throw Exception('Failed to get swim: No response from server.');
    }
    return GetSwimResDTO.fromJson(res.data);
  }

  Future<List<GetSwimResDTO>> getAllSwimsReq(GetSwimsQuery schema) async {
    try {
      final res = await _apiClient.get('/api/Swim', query: schema.toJson());
      if (res == null) {
        throw Exception('Failed to get all swims: No response from server.');
      }

      return (res.data as List)
          .map((swim) => GetSwimResDTO.fromJson(swim))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      rethrow;
    }
  }

  Future<GetSwimResDTO> updateSwimReq(
    String swimId,
    UpdateSwimReqDTO schema,
  ) async {
    try {
      final res = await _apiClient.put(
        '/api/Swim/$swimId',
        data: schema.toJson(),
      );
      if (res == null) {
        throw Exception('Failed to update swim: No response from server.');
      }
      return GetSwimResDTO.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to update swim: $e');
    }
  }

  Future<void> deleteSwimReq(String swimId) async {
    final client = await _apiClient;

    try {
      await client.delete('/api/Swim/$swimId');
    } catch (e) {
      throw Exception('Failed to delete swim: $e');
    }
  }
}
