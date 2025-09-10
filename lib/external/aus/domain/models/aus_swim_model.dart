import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/external/aus/domain/enum/aus_course_enum.dart';
import 'package:swimming_app_frontend/external/aus/domain/enum/aus_stroke_enum.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_split_entity.dart';
import 'package:swimming_app_frontend/external/aus/infrastructure/entities/aus_swim_entity.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';

@immutable
class CreateAusSwimModel {
  final String externlSwimId;
  final EventEnum event;
  final SelectedPoolTypeEnum poolType;
  final DateTime date;
  final String meetName;
  final List<CreateAusSplitModel> splits;

  const CreateAusSwimModel({
    required this.externlSwimId,
    required this.event,
    required this.poolType,
    required this.date,
    required this.meetName,
    required this.splits,
  });
}

@immutable
class CreateAusSplitModel {
  final int splitDistance;
  final double splitTime;

  const CreateAusSplitModel({
    required this.splitDistance,
    required this.splitTime,
  });
}

class AusSwimMapper {
  static CreateAusSwimModel fromEntity(
    GetAusSwimEntity swimEntity,
    List<GetAusSplitEntity> splitListEntities,
  ) {
    print('splits length: ${splitListEntities.length}');

    List<CreateAusSplitModel> insertingSplits;

    // No splits available, create a single split with total time
    if (splitListEntities.isEmpty) {
      insertingSplits = [
        CreateAusSplitModel(
          splitDistance: swimEntity.distance,
          splitTime: swimEntity.time,
        ),
      ];
    } else {
      insertingSplits = splitListEntities.map((splitEntity) {
        return CreateAusSplitModel(
          splitDistance: splitEntity.calculatedSplitDistance,
          splitTime: splitEntity.cumulativeSplitTimeMilliseconds / 1000.0,
        );
      }).toList();
    }

    return CreateAusSwimModel(
      externlSwimId: swimEntity.raceResultId,
      event: _getEventFromStrokeAndDistance(
        swimEntity.stroke,
        swimEntity.distance,
      ),
      poolType: _getPoolTypeFromCourse(swimEntity.course),
      date: swimEntity.date,
      meetName: swimEntity.meet,
      splits: insertingSplits,
    );
  }

  static EventEnum _getEventFromStrokeAndDistance(
    AusStrokeEnum stroke,
    int distance,
  ) {
    switch (stroke) {
      case AusStrokeEnum.freestyle:
        switch (distance) {
          case 50:
            return EventEnum.freestyle50;
          case 100:
            return EventEnum.freestyle100;
          case 200:
            return EventEnum.freestyle200;
          case 400:
            return EventEnum.freestyle400;
          case 800:
            return EventEnum.freestyle800;
          case 1500:
            return EventEnum.freestyle1500;
          default:
            throw ArgumentError('Unsupported freestyle distance: $distance');
        }
      case AusStrokeEnum.backstroke:
        switch (distance) {
          case 50:
            return EventEnum.backstroke50;
          case 100:
            return EventEnum.backstroke100;
          case 200:
            return EventEnum.backstroke200;
          default:
            throw ArgumentError('Unsupported backstroke distance: $distance');
        }
      case AusStrokeEnum.breaststroke:
        switch (distance) {
          case 50:
            return EventEnum.breaststroke50;
          case 100:
            return EventEnum.breaststroke100;
          case 200:
            return EventEnum.breaststroke200;
          default:
            throw ArgumentError('Unsupported breaststroke distance: $distance');
        }
      case AusStrokeEnum.butterfly:
        switch (distance) {
          case 50:
            return EventEnum.butterfly50;
          case 100:
            return EventEnum.butterfly100;
          case 200:
            return EventEnum.butterfly200;
          default:
            throw ArgumentError('Unsupported butterfly distance: $distance');
        }
      case AusStrokeEnum.medley:
        switch (distance) {
          case 100:
            return EventEnum.individualMedley100;
          case 200:
            return EventEnum.individualMedley200;
          case 400:
            return EventEnum.individualMedley400;
          default:
            throw ArgumentError('Unsupported medley distance: $distance');
        }
    }
  }

  static SelectedPoolTypeEnum _getPoolTypeFromCourse(AusCourseEnum course) {
    switch (course) {
      case AusCourseEnum.long:
        return SelectedPoolTypeEnum.longCourseMeters;
      case AusCourseEnum.short:
        return SelectedPoolTypeEnum.shortCourseMeters;
    }
  }
}
