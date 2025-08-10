import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';

class LogSplitStateModel {
  final StatusLogSwimsEnum status;

  LogSplitStateModel({this.status = StatusLogSwimsEnum.selectDistance});

  LogSplitStateModel copyWith({StatusLogSwimsEnum? status}) {
    return LogSplitStateModel(status: status ?? this.status);
  }
}
