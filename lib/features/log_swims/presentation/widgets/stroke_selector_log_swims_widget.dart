import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_event_stroke_log_swims_provider.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/stroke_button_log_swims_widget.dart';

class StrokeSelectorLogSwimsWidget extends ConsumerWidget {
  const StrokeSelectorLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStrokesState = ref.watch(selectedEventStrokeLogSwimsProvider);
    final selectedStrokesNotifier = ref.read(
      selectedEventStrokeLogSwimsProvider.notifier,
    );

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        StrokeButtonLogSwimsWidget(
          stroke: StrokeEnum.freestyle,
          isSelected: selectedStrokesNotifier.isStrokeSelected(
            StrokeEnum.freestyle,
          ),
        ),
        StrokeButtonLogSwimsWidget(
          stroke: StrokeEnum.backstroke,
          isSelected: selectedStrokesNotifier.isStrokeSelected(
            StrokeEnum.backstroke,
          ),
        ),
        StrokeButtonLogSwimsWidget(
          stroke: StrokeEnum.breaststroke,
          isSelected: selectedStrokesNotifier.isStrokeSelected(
            StrokeEnum.breaststroke,
          ),
        ),
        StrokeButtonLogSwimsWidget(
          stroke: StrokeEnum.butterfly,
          isSelected: selectedStrokesNotifier.isStrokeSelected(
            StrokeEnum.butterfly,
          ),
        ),
      ],
    );
  }
}
