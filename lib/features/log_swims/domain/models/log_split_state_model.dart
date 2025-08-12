import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_split_enum.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';

class LogSplitStateModel {
  final StatusLogSplitEnum status;
  final EventEnum event;

  LogSplitStateModel({
    this.status = StatusLogSplitEnum.selectDistance,
    required this.event,
  });

  LogSplitStateModel copyWith({StatusLogSplitEnum? status, EventEnum? event}) {
    return LogSplitStateModel(
      status: status ?? this.status,
      event: event ?? this.event,
    );
  }

  List<int> getAvailableSplitDistances() {
    switch (event) {
      case EventEnum.none:
        return [];
      case EventEnum.freestyle50:
        return [15, 20, 25, 30, 35, 40, 45, 50];
      case EventEnum.butterfly100:
      case EventEnum.backstroke100:
      case EventEnum.breaststroke100:
      case EventEnum.freestyle100:
        return [
          15,
          20,
          25,
          30,
          35,
          40,
          45,
          50,
          60,
          65,
          70,
          75,
          80,
          85,
          90,
          95,
          100,
        ];
      case EventEnum.individualMedley200:
      case EventEnum.butterfly200:
      case EventEnum.backstroke200:
      case EventEnum.breaststroke200:
      case EventEnum.freestyle200:
        return [15, 25, 50, 75, 100, 125, 150, 175, 200];
      case EventEnum.individualMedley400:
      case EventEnum.freestyle400:
        return [
          25,
          50,
          75,
          100,
          125,
          150,
          175,
          200,
          225,
          250,
          275,
          300,
          325,
          350,
          375,
          400,
        ];
      case EventEnum.freestyle800:
        return [
          50,
          100,
          150,
          200,
          250,
          300,
          350,
          400,
          450,
          500,
          550,
          600,
          650,
          700,
          750,
          800,
        ];
      case EventEnum.freestyle1500:
        return [
          50,
          100,
          150,
          200,
          250,
          300,
          350,
          400,
          450,
          500,
          550,
          600,
          650,
          700,
          750,
          800,
          850,
          900,
          950,
          1000,
          1050,
          1100,
          1150,
          1200,
          1250,
          1300,
          1350,
          1400,
          1450,
          1500,
        ];
    }
  }
}
