import 'package:swimming_app_frontend/external/aus/domain/models/aus_swim_model.dart';

@immutable
class LinkExternalSwimsModel {
  final List<GetAusParticipantEntity> searchResults;
  final List<CreateAusSwimModel> swimsToLink;

  const LinkExternalSwimsModel({
    required this.searchResults,
    required this.swimsToLink,
  });
}
