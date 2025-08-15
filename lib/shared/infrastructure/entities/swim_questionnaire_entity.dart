import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/post_swim_questionnaire_model.dart';
import 'package:swimming_app_frontend/shared/helper/json_formatting.dart';

@immutable
class GetSwimQuestionnaireEntity {
  final SelfTalkOptionsEnum selfTalk;
  final List<NervesOptionsEnum> nerves;
  final EnergyLevelOptionsEnum energyLevel;
  final BreathingOptionsEnum breathing;
  final List<CatchFeelOptionsEnum> catchFeel;
  final StrokeLengthOptionsEnum strokeLength;
  final KickTechniqueOptionsEnum kickTechnique;
  final KickThroughoutOptionsEnum kickThroughout;
  final List<HeadPositionOptionsEnum> headPosition;
  final List<TurnOptionsEnum> turn;

  const GetSwimQuestionnaireEntity({
    required this.selfTalk,
    required this.nerves,
    required this.energyLevel,
    required this.breathing,
    required this.catchFeel,
    required this.strokeLength,
    required this.kickTechnique,
    required this.kickThroughout,
    required this.headPosition,
    required this.turn,
  });

  factory GetSwimQuestionnaireEntity.fromJson(Map<String, dynamic> json) {
    return GetSwimQuestionnaireEntity(
      selfTalk: enumFromJson(SelfTalkOptionsEnum.values, json['selfTalk']),
      nerves: (json['nerves'] as List<dynamic>)
          .map((e) => enumFromJson(NervesOptionsEnum.values, e))
          .toList(),
      energyLevel: enumFromJson(
        EnergyLevelOptionsEnum.values,
        json['energyLevel'],
      ),
      breathing: enumFromJson(BreathingOptionsEnum.values, json['breathing']),
      catchFeel: (json['catchFeel'] as List<dynamic>)
          .map((e) => enumFromJson(CatchFeelOptionsEnum.values, e))
          .toList(),
      strokeLength: enumFromJson(
        StrokeLengthOptionsEnum.values,
        json['strokeLength'],
      ),
      kickTechnique: enumFromJson(
        KickTechniqueOptionsEnum.values,
        json['kickTechnique'],
      ),
      kickThroughout: enumFromJson(
        KickThroughoutOptionsEnum.values,
        json['kickThroughout'],
      ),
      headPosition: (json['headPosition'] as List<dynamic>)
          .map((e) => enumFromJson(HeadPositionOptionsEnum.values, e))
          .toList(),
      turn: (json['turn'] as List<dynamic>)
          .map((e) => enumFromJson(TurnOptionsEnum.values, e))
          .toList(),
    );
  }

  double getQuestionnaireCompleteness() {
    double completeness = 0.0;
    int totalQuestions = 10; // Total number of questions in the questionnaire

    // Count how many questions have been answered
    if (selfTalk != SelfTalkOptionsEnum.unselected) completeness++;
    if (nerves.first != NervesOptionsEnum.unselected) completeness++;
    if (energyLevel != EnergyLevelOptionsEnum.unselected) completeness++;
    if (breathing != BreathingOptionsEnum.unselected) completeness++;
    if (catchFeel.first != CatchFeelOptionsEnum.unselected) completeness++;
    if (strokeLength != StrokeLengthOptionsEnum.unselected) completeness++;
    if (kickTechnique != KickTechniqueOptionsEnum.unselected) completeness++;
    if (kickThroughout != KickThroughoutOptionsEnum.unselected) completeness++;
    if (headPosition.first != HeadPositionOptionsEnum.unselected)
      completeness++;
    if (turn.first != TurnOptionsEnum.unselected) completeness++;

    return (completeness / totalQuestions) * 100; // Return percentage
  }
}

@immutable
class CreateSwimQuestionnaireEntity {
  final SelfTalkOptionsEnum selfTalk;
  final List<NervesOptionsEnum> nerves;
  final EnergyLevelOptionsEnum energyLevel;
  final BreathingOptionsEnum breathing;
  final List<CatchFeelOptionsEnum> catchFeel;
  final StrokeLengthOptionsEnum strokeLength;
  final KickTechniqueOptionsEnum kickTechnique;
  final KickThroughoutOptionsEnum kickThroughout;
  final List<HeadPositionOptionsEnum> headPosition;
  final List<TurnOptionsEnum> turn;

  const CreateSwimQuestionnaireEntity({
    required this.selfTalk,
    required this.nerves,
    required this.energyLevel,
    required this.breathing,
    required this.catchFeel,
    required this.strokeLength,
    required this.kickTechnique,
    required this.kickThroughout,
    required this.headPosition,
    required this.turn,
  });

  Map<String, dynamic> toJson() {
    return {
      'selfTalk': enumToJson(selfTalk),
      'nerves': nerves.map((nervesSelection) {
        return enumToJson(nervesSelection);
      }).toList(),
      'energyLevel': enumToJson(energyLevel),
      'breathing': enumToJson(breathing),
      'catchFeel': catchFeel.map((catchFeelSelection) {
        return enumToJson(catchFeelSelection);
      }).toList(),
      'strokeLength': enumToJson(strokeLength),
      'kickTechnique': enumToJson(kickTechnique),
      'kickThroughout': enumToJson(kickThroughout),
      'headPosition': headPosition.map((headPositionSelection) {
        return enumToJson(headPositionSelection);
      }).toList(),
      'turn': turn.map((turnSelection) {
        return enumToJson(turnSelection);
      }).toList(),
    };
  }
}

class UpdateSwimQuestionnaireEntity {}

class SwimQuestionnaireMapper {
  static CreateSwimQuestionnaireEntity fromModelToEntity(
    CreateSwimQuestionnaireModel model,
  ) {
    return CreateSwimQuestionnaireEntity(
      selfTalk:
          model.getSelectedOptions(SelfTalkOptionsEnum).first
              as SelfTalkOptionsEnum,
      nerves: model.getSelectedOptions(NervesOptionsEnum),
      energyLevel:
          model.getSelectedOptions(EnergyLevelOptionsEnum).first
              as EnergyLevelOptionsEnum,
      breathing:
          model.getSelectedOptions(BreathingOptionsEnum).first
              as BreathingOptionsEnum,
      catchFeel: model.getSelectedOptions(CatchFeelOptionsEnum),
      strokeLength:
          model.getSelectedOptions(StrokeLengthOptionsEnum).first
              as StrokeLengthOptionsEnum,
      kickTechnique:
          model.getSelectedOptions(KickTechniqueOptionsEnum).first
              as KickTechniqueOptionsEnum,
      kickThroughout:
          model.getSelectedOptions(KickThroughoutOptionsEnum).first
              as KickThroughoutOptionsEnum,
      headPosition: model.getSelectedOptions(HeadPositionOptionsEnum),
      turn: model.getSelectedOptions(TurnOptionsEnum),
    );
  }
}
