import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/aus_api.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_participant_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_request_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_split_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_swim_entity.dart';

class AusRepository {
  final AusApiClient _apiClient;

  AusRepository(this._apiClient);

  Future<QueryResAusSwimEntity> getSwimsQueryAsync(
    QueryReqAusSwimEntity query,
    CancelToken cancelToken,
  ) async {
    final res = await _apiClient.get(
      '/results/results',
      query: query.toJson(),
      cancelToken: cancelToken,
    );

    if (res == null) {
      throw Exception('Failed to get all Aus swims: No response from server.');
    }

    final ausResponse = AusResponseEntity.fromJson(
      res.data,
      (json) => QueryResAusSwimEntity.fromJson(json as Map<String, dynamic>),
    );

    if (ausResponse.data == null) {
      return QueryResAusSwimEntity(
        pageSize: 0,
        pageNumber: 0,
        totalCount: 0,
        data: [],
      );
    } else {
      return ausResponse.data as QueryResAusSwimEntity;
    }
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

    final ausResponse = AusResponseEntity.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map((e) => GetAusSplitEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    if (ausResponse.data == null) {
      return [];
    } else {
      return ausResponse.data as List<GetAusSplitEntity>;
    }
  }

  Future<List<GetAusParticipantEntity>> getSwimmersAsync(
    String searchTerm,
    CancelToken? cancelToken,
  ) async {
    final res = await _apiClient.get(
      '/results/swimmers',
      query: {'searchTerm': searchTerm},
      cancelToken: cancelToken,
    );

    if (res == null) {
      throw Exception('Failed to get swimmers: No response from server.');
    }

    final ausResponse = AusResponseEntity.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map(
            (e) => GetAusParticipantEntity.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

    if (ausResponse.data == null) {
      return [];
    } else {
      return ausResponse.data as List<GetAusParticipantEntity>;
    }
  }
}

final ausRepositoryProvider = Provider<AusRepository>((ref) {
  final apiClient = ref.watch(ausApiClientProvider);
  return AusRepository(apiClient);
});
