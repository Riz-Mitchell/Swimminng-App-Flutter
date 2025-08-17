import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/external/aus/domain/services/aus_service.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_participant_entity.dart';
import 'package:swimming_app_frontend/features/link_external_swims/domain/models/link_external_swims_model.dart';

class LinkExternalSwimsNotifier extends Notifier<LinkExternalSwimsModel> {
  @override
  LinkExternalSwimsModel build() {
    return const LinkExternalSwimsModel(
      searchResults: [],
      selectedSwimmer: null,
      swimsToLink: [],
    );
  }

  Future<void> handleNewSearchTerm(String searchTerm) async {
    if (searchTerm.isEmpty) {
      _updateSearchResults([]);
      return;
    }

    final swimmers = await ref
        .read(ausServiceProvider)
        .getSwimmersFromAusToImport(searchTerm);

    _updateSearchResults(swimmers);
  }

  void _updateSearchResults(List<GetAusParticipantEntity> results) {
    state = state.copyWith(searchResults: results);
  }

  void selectSwimmer(GetAusParticipantEntity swimmerRef) {
    state = state.copyWith(selectedSwimmer: swimmerRef);
  }

  Future<void> getSwimsToLink() async {
    if (state.selectedSwimmer == null) {
      return;
    }

    final swims = await ref
        .read(ausServiceProvider)
        .getSwimsFromAusToImport(state.selectedSwimmer!.participantId);

    state = state.copyWith(swimsToLink: swims);
  }
}
