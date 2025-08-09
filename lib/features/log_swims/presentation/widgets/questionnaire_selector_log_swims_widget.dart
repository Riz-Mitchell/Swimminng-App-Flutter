import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/log_swims/application/post_swim_questionnaire_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/questionnaire_button_log_swims_widget.dart';

class QuestionnaireSelectorLogSwimsWidget<T extends Enum>
    extends ConsumerWidget {
  final Type questionnaireType;

  const QuestionnaireSelectorLogSwimsWidget({
    super.key,
    required this.questionnaireType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final questionnaireState = ref.watch(postSwimQuestionnaireLogSwimsProvider);
    final selectedOptionNotifier = ref.read(
      postSwimQuestionnaireLogSwimsProvider.notifier,
    );

    final List<Enum> selectedOptions = questionnaireState.getSelectedOptions(
      questionnaireType,
    );

    final options = _handleRetrieveOptions(selectedOptionNotifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                _getTitleText(questionnaireType),
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: options.map((option) {
              // print(
              //   'Building button for option: $option, selected: ${selectedOption == option}',
              // );
              return QuestionnaireButtonLogSwimsWidget<T>(
                option: option,
                isSelected: selectedOptions.contains(option),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  List<T> _handleRetrieveOptions(
    PostSwimQuestionnaireLogSwimsProvider postSwimQuestionnaireNotifier,
  ) {
    switch (questionnaireType) {
      case SelfTalkOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableSelfTalkOptions()
            .cast<T>();
      case NervesOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableNervesOptions()
            .cast<T>();
      case EnergyLevelOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableEnergyLevelOptions()
            .cast<T>();
      case BreathingOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableBreathingOptions()
            .cast<T>();
      case CatchFeelOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableCatchFeelOptions()
            .cast<T>();
      case StrokeLengthOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableStrokeLengthOptions()
            .cast<T>();
      case KickTechniqueOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableKickTechniqueOptions()
            .cast<T>();
      case KickThroughoutOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableKickThroughoutOptions()
            .cast<T>();
      case HeadPositionOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableHeadPositionOptions()
            .cast<T>();
      case TurnOptionsEnum:
        return postSwimQuestionnaireNotifier
            .getAvailableTurnOptions()
            .cast<T>();
      default:
        print('Unknown enum type: $T');
        return [];
    }
  }

  String _getTitleText(Type questionnaireType) {
    switch (questionnaireType) {
      case SelfTalkOptionsEnum:
        return 'Self Talk';
      case NervesOptionsEnum:
        return 'Nerves';
      case EnergyLevelOptionsEnum:
        return 'Energy Level';
      case BreathingOptionsEnum:
        return 'Breathing';
      case CatchFeelOptionsEnum:
        return 'Catch Feel';
      case StrokeLengthOptionsEnum:
        return 'Stroke Length';
      case KickTechniqueOptionsEnum:
        return 'Kick Technique';
      case KickThroughoutOptionsEnum:
        return 'Kick Throughout';
      case HeadPositionOptionsEnum:
        return 'Head Position';
      case TurnOptionsEnum:
        return 'Turn';
      default:
        return 'Unknown Questionnaire Type';
    }
  }
}
