import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/api.dart';
import 'package:swimming_app_frontend/api/models/swim_model.dart';

class SwimRepository {
  final ApiClient _apiClient;
  final Ref _ref;

  SwimRepository(this._ref) : _apiClient = _ref.read(apiClientProvider);

  Future<GetSwimResDTO> createSwimReq(CreateSwimReqDTO schema) async {
    try {
      final res = await _apiClient.post('/api/swim', data: schema.toJson());
      return GetSwimResDTO.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to create swim: $e');
    }
  }

  Future<GetSwimResDTO> getSwimReq(String swimId) async {
    try {
      final res = await _apiClient.get('/api/swim/$swimId');
      return GetSwimResDTO.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to get swim: $e');
    }
  }

  Future<List<GetSwimResDTO>> getAllSwimsReq(GetSwimsQuery schema) async {
    try {
      final res = await _apiClient.get('/api/swim', query: schema.toJson());
      return (res.data as List)
          .map((swim) => GetSwimResDTO.fromJson(swim))
          .toList();
    } catch (e) {
      throw Exception('Failed to get all swims: $e');
    }
  }

  Future<GetSwimResDTO> updateSwimReq(
    String swimId,
    UpdateSwimReqDTO schema,
  ) async {
    try {
      final res = await _apiClient.put(
        '/api/swim/$swimId',
        data: schema.toJson(),
      );
      return GetSwimResDTO.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to update swim: $e');
    }
  }

  Future<void> deleteSwimReq(String swimId) async {
    try {
      await _apiClient.delete('/api/swim/$swimId');
    } catch (e) {
      throw Exception('Failed to delete swim: $e');
    }
  }
}
