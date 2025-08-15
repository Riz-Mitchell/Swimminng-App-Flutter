import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_split_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_swim_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/api.dart';

class AusRepository {
  final ApiClient _apiClient;

  AusRepository(this._apiClient);

  Future<List<GetAusSwimEntity>> getAllAusSwimsAsync(
    QueryReqAusSwimEntity query,
  ) async {
    final res = await _apiClient.get('/results/results', query: query.toJson());

    if (res == null) {
      throw Exception('Failed to get all Aus swims: No response from server.');
    }

    return (res.data as List)
        .map((swim) => GetAusSwimEntity.fromJson(swim))
        .toList();
  }

  Future<List<GetAusSplitEntity>> getAllSplitsForSwimAsync(
    String raceResultId,
    QueryReqAusSplitEntity query,
  ) async {
    final res = await _apiClient.get(
      '/results/$raceResultId/splits',
      query: query.toJson(),
    );

    if (res == null) {
      throw Exception('Failed to get all Aus splits: No response from server.');
    }

    return (res.data as List)
        .map((split) => GetAusSplitEntity.fromJson(split))
        .toList();
  }
}
