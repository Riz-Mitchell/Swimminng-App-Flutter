import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/external/aus/domain/models/aus_swim_model.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_participant_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_split_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_swim_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/repositories/aus_repository.dart';

class AusService {
  final AusRepository _ausRepository;

  AusService(this._ausRepository);

  Future<List<CreateAusSwimModel>> getSwimsFromAusToImport(
    String participantId,
    CancelToken cancelToken,
  ) async {
    const int maxPageSize = 1;
    int currentPage = 1;

    List<CreateAusSwimModel> allSwims = [];

    // while (true) {
    print('Fetching page $currentPage for participant $participantId');
    final query = QueryReqAusSwimEntity(
      pageNumber: currentPage,
      pageSize: maxPageSize,
      participantId: participantId, // Replace with actual participant ID
    );

    final queryResponseEntity = await _ausRepository.getSwimsQueryAsync(
      query,
      cancelToken,
    );

    final ausSwimEntities = queryResponseEntity.data;

    if (ausSwimEntities.isEmpty) {
      // break; // No more data
    }

    final List<CreateAusSwimModel> swimEntities = [];

    for (final swimEntity in ausSwimEntities) {
      print('Fetching splits for swim: ${swimEntity.raceResultId}');
      await Future.delayed(Duration(milliseconds: 300)); // actually waits
      final splitEntities = await _ausRepository.getSplitsForRaceAsync(
        swimEntity.raceResultId,
        QueryReqAusSplitEntity(),
      );
      print(
        'Fetched ${splitEntities.length} splits for swim: ${swimEntity.raceResultId}',
      );
      swimEntities.add(AusSwimMapper.fromEntity(swimEntity, splitEntities));
    }

    allSwims.addAll(swimEntities);

    currentPage++;
    // }
    return allSwims;
  }

  Future<List<GetAusParticipantEntity>> getSwimmersFromAusToImport(
    String searchTerm,
    CancelToken? cancelToken,
  ) async {
    if (searchTerm.isEmpty) {
      return [];
    }

    final swimmers = await _ausRepository.getSwimmersAsync(
      searchTerm,
      cancelToken,
    );
    return swimmers;
  }
}

final ausServiceProvider = Provider<AusService>((ref) {
  final ausRepository = ref.watch(ausRepositoryProvider);
  return AusService(ausRepository);
});
