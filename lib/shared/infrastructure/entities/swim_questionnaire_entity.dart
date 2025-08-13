import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';

class GetSwimQuestionnaireEntity {
  SelfTalkOptionsEnum selfTalk;
  NervesOptionsEnum nerves;
  EnergyLevelOptionsEnum energyLevel;
  BreathingOptionsEnum breathing;
  CatchFeelOptionsEnum catchFeel;
  StrokeLengthOptionsEnum strokeLength;
  KickTechniqueOptionsEnum kickTechnique;
  KickThroughoutOptionsEnum kickThroughout;
  HeadPositionOptionsEnum headPosition;
  TurnOptionsEnum turn;

  GetSwimQuestionnaireEntity({
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
}

class CreateSwimQuestionnaireEntity {
  SelfTalkOptionsEnum selfTalk;
  NervesOptionsEnum nerves;
  EnergyLevelOptionsEnum energyLevel;
  BreathingOptionsEnum breathing;
  CatchFeelOptionsEnum catchFeel;
  StrokeLengthOptionsEnum strokeLength;
  KickTechniqueOptionsEnum kickTechnique;
  KickThroughoutOptionsEnum kickThroughout;
  HeadPositionOptionsEnum headPosition;
  TurnOptionsEnum turn;

  CreateSwimQuestionnaireEntity({
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
}

class UpdateSwimQuestionnaireEntity {}
