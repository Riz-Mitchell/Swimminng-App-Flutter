mixin SingleSelectEnum {}
mixin MultiSelectEnum {}

/// Only 1 can be selected at a time
enum SelfTalkOptionsEnum with SingleSelectEnum {
  unselected('assets/svg/unselected.svg'),
  none('assets/svg/self_talk/none.svg'),
  motivationalPositive('assets/svg/self_talk/motivational_positive.svg'),
  motivationalNegative('assets/svg/self_talk/motivational_negative.svg'),
  instructivePositive('assets/svg/self_talk/instructional_positive.svg'),
  instructiveNegative('assets/svg/self_talk/instructional_negative.svg'),
  outcomePositive('assets/svg/self_talk/outcome_positive.svg'),
  outcomeNegative('assets/svg/self_talk/outcome_negative.svg');

  final String svgPath;
  const SelfTalkOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}

/// Multiple options can be selected
enum NervesOptionsEnum with MultiSelectEnum {
  unselected('assets/svg/unselected.svg'),
  relaxed('assets/svg/nerves/relaxed.svg'), // Muscles loose, calm body
  jittery('assets/svg/nerves/jittery.svg'), // Shaky or twitchy (adrenaline)
  tense(
    'assets/svg/nerves/tense.svg',
  ), // Stiff muscles, clenched jaw, tight shoulders
  heavy('assets/svg/nerves/heavy.svg'), // Legs or arms feel slow, weighed down
  light('assets/svg/nerves/light.svg'), // Bouncy, springy, ready to go
  nauseous(
    'assets/svg/nerves/nauseous.svg',
  ); // Stomach discomfort, classic nervous gut

  final String svgPath;
  const NervesOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}

/// Only 1 can be selected at a time
enum EnergyLevelOptionsEnum with SingleSelectEnum {
  unselected('assets/svg/unselected.svg'),
  low('assets/svg/energy_level/low.svg'), // Tired, sluggish, no energy
  moderate(
    'assets/svg/energy_level/moderate.svg',
  ), // Some energy, not fully charged
  high('assets/svg/energy_level/high.svg'), // Full of energy, ready to go
  veryHigh(
    'assets/svg/energy_level/very_high.svg',
  ); // Overly energetic, hyperactive

  final String svgPath;
  const EnergyLevelOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}

/// Only 1 can be selected at a time
enum BreathingOptionsEnum with SingleSelectEnum {
  unselected('assets/svg/unselected.svg'),
  normal('assets/svg/breathing/normal.svg'), // Calm, steady breathing
  fast('assets/svg/breathing/fast.svg'), // Quick, shallow breaths
  deep('assets/svg/breathing/deep.svg'), // Long, deep breaths
  erratic('assets/svg/breathing/erratic.svg'); // Inconsistent, uneven breathing

  final String svgPath;
  const BreathingOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}

/// Multiple options can be selected
enum CatchFeelOptionsEnum with MultiSelectEnum {
  unselected('assets/svg/unselected.svg'),
  strong('assets/svg/catch_feel/strong.svg'),
  weak('assets/svg/catch_feel/weak.svg'),
  slipping('assets/svg/catch_feel/slipping.svg'),
  wide('assets/svg/catch_feel/wide.svg'),
  narrow('assets/svg/catch_feel/narrow.svg');

  final String svgPath;
  const CatchFeelOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}

/// Only 1 can be selected at a time
enum StrokeLengthOptionsEnum with SingleSelectEnum {
  unselected('assets/svg/unselected.svg'),
  longer('assets/svg/stroke_length/longer.svg'),
  shorter('assets/svg/stroke_length/shorter.svg');

  final String svgPath;
  const StrokeLengthOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}

/// Only 1 can be selected at a time
enum KickTechniqueOptionsEnum with SingleSelectEnum {
  unselected('assets/svg/unselected.svg'),
  small('assets/svg/kick_technique/small.svg'),
  big('assets/svg/kick_technique/big.svg');

  final String svgPath;
  const KickTechniqueOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}

/// Only 1 can be selected at a time
enum KickThroughoutOptionsEnum with SingleSelectEnum {
  unselected('assets/svg/unselected.svg'),
  consistent('assets/svg/kick_throughout/consistent.svg'),
  speedingUp('assets/svg/kick_throughout/speeding_up.svg'),
  slowingDown('assets/svg/kick_throughout/slowing_down.svg');

  final String svgPath;
  const KickThroughoutOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}

/// Multiple can be selected at a time
enum HeadPositionOptionsEnum with MultiSelectEnum {
  unselected('assets/svg/unselected.svg'),
  lookingForward('assets/svg/head_position/looking_forward.svg'),
  lookingDown('assets/svg/head_position/looking_down.svg'),
  headHigh('assets/svg/head_position/head_high.svg'),
  headLow('assets/svg/head_position/head_low.svg'),
  headNeutral('assets/svg/head_position/head_neutral.svg');

  final String svgPath;
  const HeadPositionOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}

/// Multiple can be selected at a time
enum TurnOptionsEnum with MultiSelectEnum {
  unselected('assets/svg/unselected.svg'),
  good('assets/svg/turn/good.svg'),
  tooFar('assets/svg/turn/too_far.svg'),
  tooClose('assets/svg/turn/too_close.svg'),
  feltSlow('assets/svg/turn/felt_slow.svg'),
  feltFast('assets/svg/turn/felt_fast.svg');

  final String svgPath;
  const TurnOptionsEnum(this.svgPath);

  String getSvgPath() => svgPath;
}
