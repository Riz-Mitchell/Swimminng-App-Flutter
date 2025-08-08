import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class QuestionnaireButtonLogSwimsWidget<T extends Enum> extends ConsumerWidget {
  final T option;
  final bool isSelected;

  const QuestionnaireButtonLogSwimsWidget({
    super.key,
    required this.option,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final currColor = isSelected ? metricBlue : colorScheme.secondary;

    print(option.toString());

    const widthAndHeight = 75.0;

    return GestureDetector(
      onTap: () => _handleOnTap(ref),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: currColor, width: 2),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: SvgPicture.asset(
            _getSvgPath(),
            key: ValueKey<bool>(isSelected),
            width: widthAndHeight,
            height: widthAndHeight,
            colorFilter: ColorFilter.mode(currColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  void _handleOnTap(WidgetRef ref) {}

  String _getSvgPath() {
    if (option is SelfTalkOptionsEnum) {
      return (option as SelfTalkOptionsEnum).getSvgPath();
    } else if (option is NervesOptionsEnum) {
      return (option as NervesOptionsEnum).getSvgPath();
    } else if (option is EnergyLevelOptionsEnum) {
      return (option as EnergyLevelOptionsEnum).getSvgPath();
    } else if (option is StrokeLengthOptionsEnum) {
      return (option as StrokeLengthOptionsEnum).getSvgPath();
    } else if (option is KickTechniqueOptionsEnum) {
      return (option as KickTechniqueOptionsEnum).getSvgPath();
    } else if (option is BreathingOptionsEnum) {
      return (option as BreathingOptionsEnum).getSvgPath();
    } else if (option is CatchFeelOptionsEnum) {
      return (option as CatchFeelOptionsEnum).getSvgPath();
    } else if (option is KickThroughoutOptionsEnum) {
      return (option as KickThroughoutOptionsEnum).getSvgPath();
    } else if (option is HeadPositionOptionsEnum) {
      return (option as HeadPositionOptionsEnum).getSvgPath();
    } else if (option is TurnOptionsEnum) {
      return (option as TurnOptionsEnum).getSvgPath();
    } else {
      throw Exception('Unknown option type: $T');
    }
  }
}
