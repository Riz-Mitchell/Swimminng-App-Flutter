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
  final String pagingCookie;
  final int totalCount;
  final List<GetAusSwimEntity> data;

  const QueryResAusSwimEntity({
    required this.pageSize,
    required this.pageNumber,
    required this.pagingCookie,
    required this.totalCount,
    required this.data,
  });

  factory QueryResAusSwimEntity.fromJson(Map<String, dynamic> json) {
    return QueryResAusSwimEntity(
      pageSize: json['pageSize'] as int,
      pageNumber: json['pageNumber'] as int,
      pagingCookie: json['pagingCookie'] as String,
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
      distance: json['distance'] as int,
      stroke: enumFromJson(AusStrokeEnum.values, json['stroke']),
      course: enumFromJson(AusCourseEnum.values, json['course']),
      time: (json['time'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      meet: json['meet'] as String,
    );
  }
}
