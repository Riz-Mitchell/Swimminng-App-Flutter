import 'package:flutter/material.dart';

@immutable
class GetRaceDetailsEntity {
  final String meetName;
  final DateTime date;
  final String raceResultId;

  const GetRaceDetailsEntity({
    required this.meetName,
    required this.date,
    required this.raceResultId,
  });

  factory GetRaceDetailsEntity.fromJson(Map<String, dynamic> json) {
    return GetRaceDetailsEntity(
      meetName: json['meetName'] as String,
      date: DateTime.parse(json['date'] as String).toLocal(),
      raceResultId: json['raceResultId'] as String,
    );
  }
}

@immutable
class CreateRaceDetailsEntity {
  final String meetName;
  final DateTime date;
  final String raceResultId;

  const CreateRaceDetailsEntity({
    required this.meetName,
    required this.date,
    required this.raceResultId,
  });

  Map<String, dynamic> toJson() {
    return {
      'meetName': meetName,
      'date': date.toUtc().toIso8601String(),
      'raceResultId': raceResultId,
    };
  }
}
