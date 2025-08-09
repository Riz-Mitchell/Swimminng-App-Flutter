import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/log_swims/application/post_swim_questionnaire_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/helpers/questionnaire_options_helper.dart';
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
    final textTheme = Theme.of(context).textTheme;

    const widthAndHeight = 60.0;

    return GestureDetector(
      onTap: () => _handleOnTap(ref),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: getBackGroundColor(option, isSelected, colorScheme),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: getBorderColor(option), width: 4),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: SvgPicture.asset(
                _getSvgPath(),
                key: ValueKey<bool>(isSelected),
                width: widthAndHeight,
                height: widthAndHeight,
                colorFilter: ColorFilter.mode(
                  getSvgColor(option, isSelected, colorScheme),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              textAlign: TextAlign.center,
              getSubtitle(option),
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _handleOnTap(WidgetRef ref) {
    print('Tapped option: $option, type: ${option.runtimeType}');
    ref
        .read(postSwimQuestionnaireLogSwimsProvider.notifier)
        .handleSelectedOption(option);
  }

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
