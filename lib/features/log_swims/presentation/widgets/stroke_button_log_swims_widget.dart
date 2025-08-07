import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_event_stroke_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/stroke_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class StrokeButtonLogSwimsWidget extends ConsumerWidget {
  final StrokeEnum stroke;
  final bool isSelected;

  const StrokeButtonLogSwimsWidget({
    super.key,
    required this.stroke,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final currColor = isSelected ? metricBlue : colorScheme.secondary;

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

  void _handleOnTap(WidgetRef ref) {
    final selectedEventStrokeNotifier = ref.read(
      selectedEventStrokeLogSwimsProvider.notifier,
    );

    switch (stroke) {
      case StrokeEnum.freestyle:
        selectedEventStrokeNotifier.handleTappedStroke(StrokeEnum.freestyle);
        break;
      case StrokeEnum.backstroke:
        selectedEventStrokeNotifier.handleTappedStroke(StrokeEnum.backstroke);
        break;
      case StrokeEnum.breaststroke:
        selectedEventStrokeNotifier.handleTappedStroke(StrokeEnum.breaststroke);
        break;
      case StrokeEnum.butterfly:
        selectedEventStrokeNotifier.handleTappedStroke(StrokeEnum.butterfly);
        break;
    }
  }

  String _getSvgPath() {
    switch (stroke) {
      case StrokeEnum.freestyle:
        return 'assets/svg/Freestyle.svg';
      case StrokeEnum.backstroke:
        return 'assets/svg/Backstroke.svg';
      case StrokeEnum.breaststroke:
        return 'assets/svg/Breaststroke.svg';
      case StrokeEnum.butterfly:
        return 'assets/svg/Butterfly.svg';
    }
  }
}
