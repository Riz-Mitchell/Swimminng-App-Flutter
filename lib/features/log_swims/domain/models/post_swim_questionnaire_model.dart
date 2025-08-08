import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';

class PostSwimQuestionnaireModel {
  Map<SelfTalkOptionsEnum, bool> selfTalk;
  Map<NervesOptionsEnum, bool> nerves;
  Map<EnergyLevelOptionsEnum, bool> energyLevel;
  Map<BreathingOptionsEnum, bool> breathing;
  Map<CatchFeelOptionsEnum, bool> catchFeel;
  Map<StrokeLengthOptionsEnum, bool> strokeLength;
  Map<KickTechniqueOptionsEnum, bool> kickTechnique;
  Map<KickThroughoutOptionsEnum, bool> kickThroughout;
  Map<HeadPositionOptionsEnum, bool> headPosition;
  Map<TurnOptionsEnum, bool> turn;

  PostSwimQuestionnaireModel({
    this.selfTalk = const {
      SelfTalkOptionsEnum.unselected: true,
      SelfTalkOptionsEnum.none: false,
      SelfTalkOptionsEnum.motivationalPositive: false,
      SelfTalkOptionsEnum.motivationalNegative: false,
      SelfTalkOptionsEnum.instructivePositive: false,
      SelfTalkOptionsEnum.instructiveNegative: false,
      SelfTalkOptionsEnum.outcomePositive: false,
      SelfTalkOptionsEnum.outcomeNegative: false,
    },
    this.nerves = const {
      NervesOptionsEnum.unselected: true,
      NervesOptionsEnum.relaxed: false,
      NervesOptionsEnum.jittery: false,
      NervesOptionsEnum.tense: false,
      NervesOptionsEnum.heavy: false,
      NervesOptionsEnum.light: false,
      NervesOptionsEnum.nauseous: false,
    },
    this.energyLevel = const {
      EnergyLevelOptionsEnum.unselected: true,
      EnergyLevelOptionsEnum.low: false,
      EnergyLevelOptionsEnum.moderate: false,
      EnergyLevelOptionsEnum.high: false,
      EnergyLevelOptionsEnum.veryHigh: false,
    },
    this.breathing = const {
      BreathingOptionsEnum.unselected: true,
      BreathingOptionsEnum.normal: false,
      BreathingOptionsEnum.fast: false,
      BreathingOptionsEnum.deep: false,
      BreathingOptionsEnum.erratic: false,
    },
    this.catchFeel = const {
      CatchFeelOptionsEnum.unselected: true,
      CatchFeelOptionsEnum.good: false,
      CatchFeelOptionsEnum.strong: false,
      CatchFeelOptionsEnum.weak: false,
      CatchFeelOptionsEnum.slipping: false,
      CatchFeelOptionsEnum.wide: false,
      CatchFeelOptionsEnum.narrow: false,
    },
    this.strokeLength = const {
      StrokeLengthOptionsEnum.unselected: true,
      StrokeLengthOptionsEnum.longer: false,
      StrokeLengthOptionsEnum.shorter: false,
      StrokeLengthOptionsEnum.same: false,
    },
    this.kickTechnique = const {
      KickTechniqueOptionsEnum.unselected: true,
      KickTechniqueOptionsEnum.small: false,
      KickTechniqueOptionsEnum.big: false,
    },
    this.kickThroughout = const {
      KickThroughoutOptionsEnum.unselected: true,
      KickThroughoutOptionsEnum.consistent: false,
      KickThroughoutOptionsEnum.speedingUp: false,
      KickThroughoutOptionsEnum.slowingDown: false,
    },
    this.headPosition = const {
      HeadPositionOptionsEnum.unselected: true,
      HeadPositionOptionsEnum.lookingForward: false,
      HeadPositionOptionsEnum.lookingDown: false,
      HeadPositionOptionsEnum.headHigh: false,
      HeadPositionOptionsEnum.headLow: false,
      HeadPositionOptionsEnum.headNeutral: false,
    },
    this.turn = const {
      TurnOptionsEnum.unselected: true,
      TurnOptionsEnum.good: false,
      TurnOptionsEnum.tooFar: false,
      TurnOptionsEnum.tooClose: false,
      TurnOptionsEnum.feltSlow: false,
      TurnOptionsEnum.feltFast: false,
    },
  });

  PostSwimQuestionnaireModel copyWith({
    Map<SelfTalkOptionsEnum, bool>? selfTalk,
    Map<NervesOptionsEnum, bool>? nerves,
    Map<EnergyLevelOptionsEnum, bool>? energyLevel,
    Map<BreathingOptionsEnum, bool>? breathing,
    Map<CatchFeelOptionsEnum, bool>? catchFeel,
    Map<StrokeLengthOptionsEnum, bool>? strokeLength,
    Map<KickTechniqueOptionsEnum, bool>? kickTechnique,
    Map<KickThroughoutOptionsEnum, bool>? kickThroughout,
    Map<HeadPositionOptionsEnum, bool>? headPosition,
    Map<TurnOptionsEnum, bool>? turn,
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

  PostSwimQuestionnaireModel updateQuestionnaireField<T extends Enum>(
    T option,
    Map<T, bool> currentMap,
  ) {
    final isSingleSelect = option is SingleSelectEnum;
    final isSelected = currentMap[option] ?? false;

    Map<T, bool> updatedMap;

    if (isSingleSelect) {
      updatedMap = {for (var key in currentMap.keys) key: false};
      if (!isSelected) {
        updatedMap[option] = true;
      }
    } else {
      // Multi select: toggle selected
      updatedMap = Map<T, bool>.from(currentMap);
      updatedMap[option] = !isSelected;
    }

    // Ensure first value is "unselected" if everything is false
    if (!updatedMap.containsValue(true)) {
      final firstKey = currentMap.keys.first;
      updatedMap[firstKey] = true;
    }

    switch (T) {
      case SelfTalkOptionsEnum _:
        return copyWith(selfTalk: updatedMap as Map<SelfTalkOptionsEnum, bool>);
      case NervesOptionsEnum _:
        return copyWith(nerves: updatedMap as Map<NervesOptionsEnum, bool>);
      case EnergyLevelOptionsEnum _:
        return copyWith(
          energyLevel: updatedMap as Map<EnergyLevelOptionsEnum, bool>,
        );
      case BreathingOptionsEnum _:
        return copyWith(
          breathing: updatedMap as Map<BreathingOptionsEnum, bool>,
        );
      case CatchFeelOptionsEnum _:
        return copyWith(
          catchFeel: updatedMap as Map<CatchFeelOptionsEnum, bool>,
        );
      case StrokeLengthOptionsEnum _:
        return copyWith(
          strokeLength: updatedMap as Map<StrokeLengthOptionsEnum, bool>,
        );
      case KickTechniqueOptionsEnum _:
        return copyWith(
          kickTechnique: updatedMap as Map<KickTechniqueOptionsEnum, bool>,
        );
      case KickThroughoutOptionsEnum _:
        return copyWith(
          kickThroughout: updatedMap as Map<KickThroughoutOptionsEnum, bool>,
        );
      case HeadPositionOptionsEnum _:
        return copyWith(
          headPosition: updatedMap as Map<HeadPositionOptionsEnum, bool>,
        );
      case TurnOptionsEnum _:
        return copyWith(turn: updatedMap as Map<TurnOptionsEnum, bool>);
      default:
        throw Exception('Unknown enum type: $T');
    }
  }
}
