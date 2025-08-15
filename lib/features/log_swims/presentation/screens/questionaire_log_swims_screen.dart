import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/log_swims_shell_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/header_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/questionnaire_selector_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class QuestionnaireLogSwimsScreen extends ConsumerWidget {
  const QuestionnaireLogSwimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return LogSwimsShellScreen(
      child: Column(
        spacing: 40,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderLogSwimsWidget(),
          Text(
            'Notes',
            style: textTheme.displaySmall?.copyWith(color: colorScheme.primary),
          ),
          QuestionnaireSelectorLogSwimsWidget<SelfTalkOptionsEnum>(
            questionnaireType: SelfTalkOptionsEnum,
          ),
          QuestionnaireSelectorLogSwimsWidget<NervesOptionsEnum>(
            questionnaireType: NervesOptionsEnum,
          ),
          QuestionnaireSelectorLogSwimsWidget<EnergyLevelOptionsEnum>(
            questionnaireType: EnergyLevelOptionsEnum,
          ),
          QuestionnaireSelectorLogSwimsWidget<BreathingOptionsEnum>(
            questionnaireType: BreathingOptionsEnum,
          ),
          QuestionnaireSelectorLogSwimsWidget<CatchFeelOptionsEnum>(
            questionnaireType: CatchFeelOptionsEnum,
          ),
          QuestionnaireSelectorLogSwimsWidget<StrokeLengthOptionsEnum>(
            questionnaireType: StrokeLengthOptionsEnum,
          ),
          QuestionnaireSelectorLogSwimsWidget<KickTechniqueOptionsEnum>(
            questionnaireType: KickTechniqueOptionsEnum,
          ),
          QuestionnaireSelectorLogSwimsWidget<KickThroughoutOptionsEnum>(
            questionnaireType: KickThroughoutOptionsEnum,
          ),
          QuestionnaireSelectorLogSwimsWidget<HeadPositionOptionsEnum>(
            questionnaireType: HeadPositionOptionsEnum,
          ),
          QuestionnaireSelectorLogSwimsWidget<TurnOptionsEnum>(
            questionnaireType: TurnOptionsEnum,
          ),
          SizedBox(height: 50),
          MetricButtonWidget(
            text: 'Next',
            onPressed: () async {
              if (true) {
                await ref.read(logSwimProvider.notifier).navigateToNextStep();
              }
            },
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
