import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_participant_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_request_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_split_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_swim_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/api.dart';

class AusRepository {
  final ApiClient _apiClient;

  AusRepository(this._apiClient);

  Future<QueryResAusSwimEntity> getSwimsQueryAsync(
    QueryReqAusSwimEntity query,
  ) async {
    final res = await _apiClient.get('/results/results', query: query.toJson());

    if (res == null) {
      throw Exception('Failed to get all Aus swims: No response from server.');
    }

    final AusResponseEntity<QueryResAusSwimEntity> ausResponse =
        res.data as AusResponseEntity<QueryResAusSwimEntity>;

    return ausResponse.data;
  }

  Future<List<GetAusSplitEntity>> getSplitsForRaceAsync(
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

    final AusResponseEntity<List<GetAusSplitEntity>> ausResponse =
        res.data as AusResponseEntity<List<GetAusSplitEntity>>;

    return ausResponse.data;
  }

  Future<List<GetAusParticipantEntity>> getSwimmersAsync(
    String searchTerm,
  ) async {
    final res = await _apiClient.get(
      '/results/swimmers',
      query: {'searchTerm': searchTerm},
    );

    if (res == null) {
      throw Exception('Failed to get swimmers: No response from server.');
    }

    final AusResponseEntity<List<GetAusParticipantEntity>> ausResponse =
        res.data as AusResponseEntity<List<GetAusParticipantEntity>>;

    return ausResponse.data;
  }
}

final ausRepositoryProvider = Provider<AusRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AusRepository(apiClient);
});
