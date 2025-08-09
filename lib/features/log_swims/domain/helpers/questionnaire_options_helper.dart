import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

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

Color getBackGroundColor(
  Enum option,
  bool isSelected,
  ColorScheme colorScheme,
) {
  if (option is SelfTalkOptionsEnum ||
      option is NervesOptionsEnum ||
      option is EnergyLevelOptionsEnum) {
    return isSelected ? metricGreen : colorScheme.background;
  } else if (option is BreathingOptionsEnum) {
    return isSelected ? metricYellow : colorScheme.background;
  } else if (option is StrokeLengthOptionsEnum ||
      option is CatchFeelOptionsEnum) {
    return isSelected ? metricRed : colorScheme.background;
  } else if (option is KickTechniqueOptionsEnum ||
      option is KickThroughoutOptionsEnum) {
    return isSelected ? metricOrange : colorScheme.background;
  } else {
    return isSelected ? metricPurple : colorScheme.background;
  }
}

Color getSvgColor(Enum option, bool isSelected, ColorScheme colorScheme) {
  if (option is SelfTalkOptionsEnum ||
      option is NervesOptionsEnum ||
      option is EnergyLevelOptionsEnum) {
    return isSelected ? colorScheme.background : metricGreen;
  } else if (option is BreathingOptionsEnum) {
    return isSelected ? colorScheme.background : metricYellow;
  } else if (option is StrokeLengthOptionsEnum ||
      option is CatchFeelOptionsEnum) {
    return isSelected ? colorScheme.background : metricRed;
  } else if (option is KickTechniqueOptionsEnum ||
      option is KickThroughoutOptionsEnum) {
    return isSelected ? colorScheme.background : metricOrange;
  } else {
    return isSelected ? colorScheme.background : metricPurple;
  }
}

Color getBorderColor(Enum option) {
  if (option is SelfTalkOptionsEnum ||
      option is NervesOptionsEnum ||
      option is EnergyLevelOptionsEnum) {
    return metricGreen;
  } else if (option is BreathingOptionsEnum) {
    return metricYellow;
  } else if (option is StrokeLengthOptionsEnum ||
      option is CatchFeelOptionsEnum) {
    return metricRed;
  } else if (option is KickTechniqueOptionsEnum ||
      option is KickThroughoutOptionsEnum) {
    return metricOrange;
  } else {
    return metricPurple;
  }
}
