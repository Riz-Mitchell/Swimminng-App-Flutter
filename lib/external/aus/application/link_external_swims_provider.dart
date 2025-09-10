import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/external/aus/domain/services/aus_service.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_participant_entity.dart';
import 'package:swimming_app_frontend/features/link_external_swims/domain/models/link_external_swims_model.dart';

class LinkExternalSwimsNotifier
    extends AutoDisposeAsyncNotifier<LinkExternalSwimsModel> {
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
    if (state.value == null) return;

    // No change if the same swimmer is already selected
    if (state.value!.selectedSwimmer == swimmerRef) return;

    // Update selected swimmer in state
    state = AsyncData(state.value!.copyWith(selectedSwimmer: swimmerRef));

    // Cancel any ongoing swim-fetch request
    _cancelToken?.cancel("Selecting new swimmer");

    // Create a new cancel token for this request
    _cancelToken = CancelToken();

    // Fetch swims for this swimmer
    _getSwimsToLinkWithCancel(_cancelToken!);
  }

  Future<void> _getSwimsToLinkWithCancel(CancelToken token) async {
    final swimmer = state.value?.selectedSwimmer;
    if (swimmer == null) return;

    try {
      final swims = await ref
          .read(ausServiceProvider)
          .getSwimsFromAusToImport(swimmer.participantId, token);

      // Only update if still valid (not canceled)
      if (!token.isCancelled) {
        state = AsyncData(state.value!.copyWith(swimsToLink: swims));
      }
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        print("Fetch swims canceled");
      } else {
        print("Fetch swims failed: $e");
      }
    }
  }
}

final linkExternalSwimsProvider =
    AutoDisposeAsyncNotifierProvider<
      LinkExternalSwimsNotifier,
      LinkExternalSwimsModel
    >(() => LinkExternalSwimsNotifier());
