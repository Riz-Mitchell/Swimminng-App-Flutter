import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_split_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/split_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';

class LogSplitStateModel {
  final StatusLogSplitEnum status;
  final EventEnum event;
  final int? distance;
  final double? time;
  final int? rate;
  final int? count;

  LogSplitStateModel({
    this.status = StatusLogSplitEnum.selectDistance,
    required this.event,
    this.distance,
    this.time,
    this.rate,
    this.count,
  });

  LogSplitStateModel copyWith({
    StatusLogSplitEnum? status,
    EventEnum? event,
    int? distance,
    double? time,
    int? rate,
    int? count,
  }) {
    return LogSplitStateModel(
      status: status ?? this.status,
      event: event ?? this.event,
      distance: distance,
      time: time,
      rate: rate,
      count: count,
    );
  }

  bool isDistanceValid() {
    if (distance == null || distance! <= 0) {
      return false;
    }
    return true;
  }

  bool isTimeValid() {
    if (time == null || time! <= 0) {
      return false;
    }
    return true;
  }

  bool isRateValid() {
    if (rate == null || rate! <= 0) {
      return false;
    }
    return true;
  }

  bool isCountValid() {
    if (count == null || count! <= 0) {
      return false;
    }
    return true;
  }
}
