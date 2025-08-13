import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/post_swim_questionnaire_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/split_entity.dart';

class GetSwimEntity {
  String id;
  EventEnum event;
  SelectedPoolTypeEnum poolType;
  List<GetSplitEntity> splits;
  GetSwimQuestionnaireEntity questionnaire;
  DateTime recordedAt;

  GetSwimEntity({
    required this.id,
    required this.event,
    required this.poolType,
    required this.splits,
    required this.questionnaire,
    required this.recordedAt,
  });
}

class CreateSwimEntity {
  final EventEnum event; // Event type
  final List<CreateSplitEntity> splits; // Splits for this swim
  final bool goalSwim; // Whether this is a goal swim
  final SelectedPoolTypeEnum poolType; // Pool type
  final CreateSwimQuestionnaireEntity questionnaire;

  CreateSwimEntity({
    required this.event,
    required this.splits,
    this.goalSwim = false,
    required this.poolType,
    required this.questionnaire,
  });
}

class UpdateSwimEntity {}
