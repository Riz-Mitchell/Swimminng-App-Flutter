import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/post_swim_questionnaire_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/split_entity.dart';

class GetSwimEntity {
  String id;
  EventEnum event;
  SelectedPoolTypeEnum poolType;
  List<GetSplitEntity> splits;
  PostSwimQuestionnaireModel questionnaire;
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

class CreateSwimEntity {}

class UpdateSwimEntity {}
