import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/post_swim_questionnaire_model.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/split_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';

class LogSwimStateModel {
  final SelectedPoolTypeEnum poolType;
  final EventEnum event;
  final StatusLogSwimsEnum status;
  final List<SplitModel> splits;
  final PostSwimQuestionnaireModel questionnaire;

  LogSwimStateModel({
    required this.poolType,
    required this.event,
    required this.status,
    required this.questionnaire,
    required this.splits,
  });

  LogSwimStateModel copyWith({
    SelectedPoolTypeEnum? poolType,
    EventEnum? event,
    StatusLogSwimsEnum? status,
    PostSwimQuestionnaireModel? questionnaire,
    List<SplitModel>? splits,
  }) {
    return LogSwimStateModel(
      poolType: poolType ?? this.poolType,
      event: event ?? this.event,
      status: status ?? this.status,
      splits: splits ?? this.splits,
      questionnaire: questionnaire ?? this.questionnaire,
    );
  }

  List<int> getAvailableSplitDistances() {
    print('Getting available split distances for event: $event');
    List<int> usedDistances = getUsedDistances();
    print('Printing used distances: $usedDistances');
    for (var split in splits) {
      print('Split distance: ${split.intervalDistance}');
    }
    List<int> availableDistances = [];

    switch (event) {
      case EventEnum.none:
        availableDistances = [];
      case EventEnum.freestyle50:
        availableDistances = [15, 20, 25, 30, 35, 40, 45, 50];
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
    print('Available distances after filtering: $availableDistances');
    for (var distance in availableDistances) {
      print('Available distance: $distance');
    }

    return availableDistances;
  }

  List<int> getUsedDistances() {
    return splits.map((split) => split.intervalDistance).toList();
  }
}
