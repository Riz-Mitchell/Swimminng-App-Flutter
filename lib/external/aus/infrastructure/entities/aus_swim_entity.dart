import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/external/aus/domain/enum/aus_course_enum.dart';
import 'package:swimming_app_frontend/external/aus/domain/enum/aus_stroke_enum.dart';
import 'package:swimming_app_frontend/shared/helper/json_formatting.dart';

@immutable
class QueryReqAusSwimEntity {
  final int pageNumber;
  final int pageSize;
  final bool sortDate;
  final String participantId;

  const QueryReqAusSwimEntity({
    this.pageNumber = 1,
    this.pageSize = 20,
    this.sortDate = false,
    required this.participantId,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'sortDate': sortDate,
      'participantId': participantId,
    };
  }
}

@immutable
class QueryResAusSwimEntity {
  final int pageSize;
  final int pageNumber;
  final int totalCount;
  final List<GetAusSwimEntity> data;

  const QueryResAusSwimEntity({
    required this.pageSize,
    required this.pageNumber,
    required this.totalCount,
    required this.data,
  });

  factory QueryResAusSwimEntity.fromJson(Map<String, dynamic> json) {
    return QueryResAusSwimEntity(
      pageSize: json['pageSize'] as int,
      pageNumber: json['pageNumber'] as int,
      totalCount: json['totalCount'] as int,
      data: (json['data'] as List)
          .map((item) => GetAusSwimEntity.fromJson(item))
          .toList(),
    );
  }
}

@immutable
class GetAusSwimEntity {
  final String raceResultId;
  final int distance;
  final AusStrokeEnum stroke;
  final AusCourseEnum course;
  final double time;
  final DateTime date;
  final String meet;

  const GetAusSwimEntity({
    required this.raceResultId,
    required this.distance,
    required this.stroke,
    required this.course,
    required this.time,
    required this.date,
    required this.meet,
  });

  factory GetAusSwimEntity.fromJson(Map<String, dynamic> json) {
    return GetAusSwimEntity(
      raceResultId: json['raceResultId'] as String,
      distance: (json['distance'] as num).toInt(),
      stroke: enumFromJson(AusStrokeEnum.values, json['stroke']),
      course: enumFromJson(AusCourseEnum.values, json['course']),
      time: _parseTime(json['time']),
      date: DateTime.parse(json['date'] as String),
      meet: json['meet'] as String,
    );
  }

  static double _parseTime(dynamic value) {
    if (value == null) return 0.0;

    // If it's already a double or int
    if (value is num) {
      return value.toDouble();
    }

    // If it's a string, parse it
    if (value is String) {
      final parts = value.split(':');

      if (parts.length == 2) {
        // Format mm:ss.ss
        final minutes = double.tryParse(parts[0]) ?? 0.0;
        final seconds = double.tryParse(parts[1]) ?? 0.0;
        return (minutes * 60) + seconds;
      } else if (parts.length == 1) {
        // Just seconds as a string
        return double.tryParse(parts[0]) ?? 0.0;
      }
    }

    throw FormatException('Invalid time format: $value');
  }
}
