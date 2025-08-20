import 'package:flutter/material.dart';

@immutable
class QueryReqAusSplitEntity {
  final bool searchArchives;

  const QueryReqAusSplitEntity({this.searchArchives = false});

  Map<String, dynamic> toJson() {
    return {'searchArchives': searchArchives};
  }
}

@immutable
class GetAusSplitEntity {
  final String raceResultSplitId;
  final int calculatedSplitDistance;
  final int cumulativeSplitTimeMilliseconds;

  const GetAusSplitEntity({
    required this.raceResultSplitId,
    required this.calculatedSplitDistance,
    required this.cumulativeSplitTimeMilliseconds,
  });

  factory GetAusSplitEntity.fromJson(Map<String, dynamic> json) {
    return GetAusSplitEntity(
      raceResultSplitId: json['raceResultSplitId'] as String,
      calculatedSplitDistance: json['calculatedSplitDistance'] as int,
      cumulativeSplitTimeMilliseconds:
          json['cumulativeSplitTimeMilliseconds'] as int,
    );
  }
}
