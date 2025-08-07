import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';

class PostSwimQuestionnaireModel {
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

  PostSwimQuestionnaireModel({
    this.selfTalk = SelfTalkOptionsEnum.unselected,
    this.nerves = NervesOptionsEnum.unselected,
    this.energyLevel = EnergyLevelOptionsEnum.unselected,
    this.breathing = BreathingOptionsEnum.unselected,
    this.catchFeel = CatchFeelOptionsEnum.unselected,
    this.strokeLength = StrokeLengthOptionsEnum.unselected,
    this.kickTechnique = KickTechniqueOptionsEnum.unselected,
    this.kickThroughout = KickThroughoutOptionsEnum.unselected,
    this.headPosition = HeadPositionOptionsEnum.unselected,
    this.turn = TurnOptionsEnum.unselected,
  });

  PostSwimQuestionnaireModel copyWith({
    SelfTalkOptionsEnum? selfTalk,
    NervesOptionsEnum? nerves,
    EnergyLevelOptionsEnum? energyLevel,
    BreathingOptionsEnum? breathing,
    CatchFeelOptionsEnum? catchFeel,
    StrokeLengthOptionsEnum? strokeLength,
    KickTechniqueOptionsEnum? kickTechnique,
    KickThroughoutOptionsEnum? kickThroughout,
    HeadPositionOptionsEnum? headPosition,
    TurnOptionsEnum? turn,
  }) {
    return PostSwimQuestionnaireModel(
      selfTalk: selfTalk ?? this.selfTalk,
      nerves: nerves ?? this.nerves,
      energyLevel: energyLevel ?? this.energyLevel,
      breathing: breathing ?? this.breathing,
      catchFeel: catchFeel ?? this.catchFeel,
      strokeLength: strokeLength ?? this.strokeLength,
      kickTechnique: kickTechnique ?? this.kickTechnique,
      kickThroughout: kickThroughout ?? this.kickThroughout,
      headPosition: headPosition ?? this.headPosition,
      turn: turn ?? this.turn,
    );
  }
}
