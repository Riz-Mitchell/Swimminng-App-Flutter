import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/external/aus/domain/models/aus_swim_model.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_participant_entity.dart';

@immutable
class LinkExternalSwimsModel {
  final List<GetAusParticipantEntity> searchResults;
  final List<GetAusParticipantEntity> selectedSwimmer;
  final List<CreateAusSwimModel> swimsToLink;

  const LinkExternalSwimsModel({
    required this.searchResults,
    required this.selectedSwimmer,
    required this.swimsToLink,
  });

  LinkExternalSwimsModel copyWith({
    List<GetAusParticipantEntity>? searchResults,
    List<GetAusParticipantEntity>? selectedSwimmer,
    List<CreateAusSwimModel>? swimsToLink,
  }) {
    return LinkExternalSwimsModel(
      searchResults: searchResults ?? this.searchResults,
      selectedSwimmer: selectedSwimmer ?? this.selectedSwimmer,
      swimsToLink: swimsToLink ?? this.swimsToLink,
    );
  }

  CreateAusSwimModel getMostRecentSwim() {
    return swimsToLink.reduce((a, b) {
      return a.date.isAfter(b.date) ? a : b;
    });
  }
}
