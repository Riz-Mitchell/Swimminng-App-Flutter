import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';

String getSubtitle(Enum option) {
  switch (option) {
    case SelfTalkOptionsEnum.none:
      return 'None';
    case SelfTalkOptionsEnum.motivationalPositive:
      return 'Motivational Positive';
    case SelfTalkOptionsEnum.motivationalNegative:
      return 'Motivational Negative';
    case SelfTalkOptionsEnum.instructivePositive:
      return 'Instructive Positive';
    case SelfTalkOptionsEnum.instructiveNegative:
      return 'Instructive Negative';
    case SelfTalkOptionsEnum.outcomePositive:
      return 'Outcome Positive';
    case SelfTalkOptionsEnum.outcomeNegative:
      return 'Outcome Negative';
    case NervesOptionsEnum.relaxed:
      return 'Relaxed';
    case NervesOptionsEnum.jittery:
      return 'Jittery';
    case NervesOptionsEnum.tense:
      return 'Tense';
    case NervesOptionsEnum.heavy:
      return 'Heavy';
    case NervesOptionsEnum.light:
      return 'Light';
    case NervesOptionsEnum.nauseous:
      return 'Nauseous';
    case EnergyLevelOptionsEnum.low:
      return 'Low';
    case EnergyLevelOptionsEnum.moderate:
      return 'Moderate';
    case EnergyLevelOptionsEnum.high:
      return 'High';
    case EnergyLevelOptionsEnum.veryHigh:
      return 'Very High';
    case BreathingOptionsEnum.normal:
      return 'Normal';
    case BreathingOptionsEnum.fast:
      return 'Fast';
    case BreathingOptionsEnum.deep:
      return 'Deep';
    case BreathingOptionsEnum.erratic:
      return 'Erratic';
    case CatchFeelOptionsEnum.strong:
      return 'Strong';
    case CatchFeelOptionsEnum.weak:
      return 'Weak';
    case CatchFeelOptionsEnum.slipping:
      return 'Slipping';
    case CatchFeelOptionsEnum.wide:
      return 'Wide';
    case CatchFeelOptionsEnum.narrow:
      return 'Narrow';
    case StrokeLengthOptionsEnum.shorter:
      return 'Short';
    case StrokeLengthOptionsEnum.longer:
      return 'Long';
    case KickTechniqueOptionsEnum.big:
      return 'Big';
    case KickTechniqueOptionsEnum.small:
      return 'Small';
    case KickThroughoutOptionsEnum.consistent:
      return 'Consistent';
    case KickThroughoutOptionsEnum.speedingUp:
      return 'Speeding Up';
    case KickThroughoutOptionsEnum.slowingDown:
      return 'Slowing Down';
    case HeadPositionOptionsEnum.lookingForward:
      return 'Looking Forward';
    case HeadPositionOptionsEnum.lookingDown:
      return 'Looking Down';
    case HeadPositionOptionsEnum.headHigh:
      return 'Head High';
    case HeadPositionOptionsEnum.headLow:
      return 'Head Low';
    case HeadPositionOptionsEnum.headNeutral:
      return 'Head Neutral';
    case TurnOptionsEnum.good:
      return 'Good';
    case TurnOptionsEnum.tooFar:
      return 'Too Far';
    case TurnOptionsEnum.tooClose:
      return 'Too Close';
    case TurnOptionsEnum.feltSlow:
      return 'Felt Slow';
    case TurnOptionsEnum.feltFast:
      return 'Felt Fast';
    default:
      return 'Unknown';
  }
}
