import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/post_swim_questionnaire_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/questionnaire_button_log_swims_widget.dart';

class QuestionnaireSelectorLogSwimsWidget<T extends Enum>
    extends ConsumerWidget {
  const QuestionnaireSelectorLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption = ref.watch(postSwimQuestionnaireLogSwimsProvider);
    final selectedOptionNotifier = ref.read(
      postSwimQuestionnaireLogSwimsProvider.notifier,
    );

    final options = _handleRetrieveOptions(selectedOptionNotifier);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options
            .map(
              (option) => QuestionnaireButtonLogSwimsWidget<T>(
                option: option,
                isSelected: (selectedOption == option),
              ),
            )
            .toList(),
      ),
    );
  }

  List<T> _handleRetrieveOptions(
    PostSwimQuestionnaireLogSwimsProvider postSwimQuestionnaireNotifier,
  ) {
    switch (T) {
      case SelfTalkOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableSelfTalkOptions()
            .cast<T>();
      case NervesOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableNervesOptions()
            .cast<T>();
      case EnergyLevelOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableEnergyLevelOptions()
            .cast<T>();
      case BreathingOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableBreathingOptions()
            .cast<T>();
      case CatchFeelOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableCatchFeelOptions()
            .cast<T>();
      case StrokeLengthOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableStrokeLengthOptions()
            .cast<T>();
      case KickTechniqueOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableKickTechniqueOptions()
            .cast<T>();
      case KickThroughoutOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableKickThroughoutOptions()
            .cast<T>();
      case HeadPositionOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableHeadPositionOptions()
            .cast<T>();
      case TurnOptionsEnum _:
        return postSwimQuestionnaireNotifier
            .getAvailableTurnOptions()
            .cast<T>();
      default:
        return [];
    }
  }
}
