import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';

class LogSwimStateModel {
  final StatusLogSwimsEnum status;

  LogSwimStateModel({required this.status});

  LogSwimStateModel copyWith({StatusLogSwimsEnum? status}) {
    return LogSwimStateModel(status: status ?? this.status);
  }
}
