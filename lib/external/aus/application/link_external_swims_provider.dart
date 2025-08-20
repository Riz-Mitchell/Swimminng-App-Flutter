import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/external/aus/domain/services/aus_service.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_participant_entity.dart';
import 'package:swimming_app_frontend/features/link_external_swims/domain/models/link_external_swims_model.dart';

class LinkExternalSwimsNotifier extends AsyncNotifier<LinkExternalSwimsModel> {
  Timer? _debounceTimer;
  CancelToken? _cancelToken;

  @override
  Future<LinkExternalSwimsModel> build() async {
    return const LinkExternalSwimsModel(
      searchResults: [],
      selectedSwimmer: null,
      swimsToLink: [],
    );
  }

  Future<void> handleNewSearchTerm(String searchTerm) async {
    // Cancel previous debounce timer
    _debounceTimer?.cancel();

    // Cancel previous request if it exists
    _cancelToken?.cancel("New search term entered");

    // Start a new debounce timer
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      if (searchTerm.isEmpty) {
        _updateSearchResults([]);
        return;
      }

      _cancelToken = CancelToken();

      try {
        final swimmers = await ref
            .read(ausServiceProvider)
            .getSwimmersFromAusToImport(searchTerm, _cancelToken);

        _updateSearchResults(swimmers);
      } on DioException catch (e) {
        if (CancelToken.isCancel(e)) {
          print("Previous search canceled");
        } else {
          print("Search failed: $e");
        }
      }
    });
  }

  void _updateSearchResults(List<GetAusParticipantEntity> results) {
    state = AsyncData(state.value!.copyWith(searchResults: results));
  }

  void selectSwimmer(GetAusParticipantEntity swimmerRef) {
    state = AsyncData(state.value!.copyWith(selectedSwimmer: swimmerRef));
  }

  Future<void> getSwimsToLink() async {
    if (state.value!.selectedSwimmer == null) {
      return;
    }

    final swims = await ref
        .read(ausServiceProvider)
        .getSwimsFromAusToImport(state.value!.selectedSwimmer!.participantId);

    state = AsyncData(state.value!.copyWith(swimsToLink: swims));
  }
}

final linkExternalSwimsProvider =
    AsyncNotifierProvider<LinkExternalSwimsNotifier, LinkExternalSwimsModel>(
      () => LinkExternalSwimsNotifier(),
    );
