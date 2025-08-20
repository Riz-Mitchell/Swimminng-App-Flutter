import 'package:flutter/material.dart';

@immutable
class GetAusParticipantEntity {
  final String participantId;
  final String fullName;
  final String? club;

  const GetAusParticipantEntity({
    required this.participantId,
    required this.fullName,
    required this.club,
  });

  factory GetAusParticipantEntity.fromJson(Map<String, dynamic> json) {
    return GetAusParticipantEntity(
      participantId: json['participantId'] as String,
      fullName: json['fullName'] as String,
      club: json['club'] as String?,
    );
  }
}
