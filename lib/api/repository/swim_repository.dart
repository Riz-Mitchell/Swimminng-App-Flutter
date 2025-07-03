import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/api.dart';
import 'package:swimming_app_frontend/api/models/swim_model.dart';

class SwimRepository {
  final ApiClient _apiClient;
  final Ref _ref;

  SwimRepository(this._ref) : _apiClient = _ref.read(apiClientProvider);

  Future<GetSwimResDTO> createSwimReq(CreateSwimReqDTO schema) async {
    try {
      final res = await _apiClient.post('/api/Swim', data: schema.toJson());

      if (res == null) {
        throw Exception('Failed to create swim: No response from server.');
      }
      return GetSwimResDTO.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to create swim: $e');
    }
  }

  Future<GetSwimResDTO> getSwimReq(String swimId) async {
    try {
      final res = await _apiClient.get('/api/Swim/$swimId');
      if (res == null) {
        throw Exception('Failed to create swim: No response from server.');
      }
      return GetSwimResDTO.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to get swim: $e');
    }
  }

  Future<List<GetSwimResDTO>> getAllSwimsReq(GetSwimsQuery schema) async {
    try {
      final res = await _apiClient.get('/api/Swim', query: schema.toJson());
      if (res == null) {
        throw Exception('Failed to create swim: No response from server.');
      }
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
        '/api/Swim/$swimId',
        data: schema.toJson(),
      );
      if (res == null) {
        throw Exception('Failed to create swim: No response from server.');
      }
      return GetSwimResDTO.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to update swim: $e');
    }
  }

  Future<void> deleteSwimReq(String swimId) async {
    try {
      await _apiClient.delete('/api/Swim/$swimId');
    } catch (e) {
      throw Exception('Failed to delete swim: $e');
    }
  }
}
