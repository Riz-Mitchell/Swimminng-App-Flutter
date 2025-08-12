import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/split_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';

class LogSwimStateModel {
  final EventEnum event;
  final StatusLogSwimsEnum status;
  final List<SplitModel> splits;

  LogSwimStateModel({
    required this.event,
    required this.status,
    List<SplitModel>? splits,
  }) : splits = splits ?? [];

  LogSwimStateModel copyWith({
    EventEnum? event,
    StatusLogSwimsEnum? status,
    List<SplitModel>? splits,
  }) {
    return LogSwimStateModel(
      event: event ?? this.event,
      status: status ?? this.status,
      splits: splits ?? this.splits,
    );
  }

  List<int> getAvailableSplitDistances() {
    List<int> usedDistances = getUsedDistances();
    List<int> availableDistances = [];

    switch (event) {
      case EventEnum.none:
        availableDistances = [];
      case EventEnum.freestyle50:
        return [15, 20, 25, 30, 35, 40, 45, 50];
      case EventEnum.butterfly100:
      case EventEnum.backstroke100:
      case EventEnum.breaststroke100:
      case EventEnum.freestyle100:
        availableDistances = [
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
        availableDistances = [15, 25, 50, 75, 100, 125, 150, 175, 200];
      case EventEnum.individualMedley400:
      case EventEnum.freestyle400:
        availableDistances = [
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
        availableDistances = [
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
        availableDistances = [
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

    // Filter out used distances
    availableDistances.removeWhere(
      (distance) => usedDistances.contains(distance),
    );

    return availableDistances;
  }

  List<int> getUsedDistances() {
    return splits.map((split) => split.intervalDistance).toList();
  }
}
