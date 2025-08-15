import 'package:swimming_app_frontend/external/aus/domain/models/aus_swim_model.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_split_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_swim_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/repositories/aus_repository.dart';

class AusService {
  final AusRepository _ausRepository;

  AusService(this._ausRepository);

  Future<List<CreateAusSwimModel>> getSwimsFromAusToImport(
    String participantId,
  ) async {
    const int maxPageSize = 20;
    int currentPage = 1;

    List<CreateAusSwimModel> allSwims = [];

    while (true) {
      final query = QueryReqAusSwimEntity(
        pageNumber: currentPage,
        pageSize: maxPageSize,
        participantId: participantId, // Replace with actual participant ID
      );

      final ausSwimEntities = await _ausRepository.getAllAusSwimsAsync(query);

      if (ausSwimEntities.isEmpty) {
        break; // No more data
      }

      final swimEntities = await Future.wait(
        ausSwimEntities.map((swimEntity) async {
          final splitQuery = QueryReqAusSplitEntity();
          final splitEntities = await _ausRepository.getAllSplitsForSwimAsync(
            swimEntity.raceResultId,
            splitQuery,
          );
          return AusSwimMapper.fromEntity(swimEntity, splitEntities);
        }),
      );

      allSwims.addAll(swimEntities);
      currentPage++;
    }
    return allSwims;
  }
}
