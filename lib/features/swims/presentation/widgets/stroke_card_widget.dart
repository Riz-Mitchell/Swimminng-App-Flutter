import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/event_selection_provider.dart.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/form/add_swim_form.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';

class StrokeCardWidget extends ConsumerWidget {
  final freestyleSvgPath = 'assets/svg/Freestyle.svg';
  final backstrokeSvgPath = 'assets/svg/Backstroke.svg';
  final breaststrokeSvgPath = 'assets/svg/Breaststroke.svg';
  final butterflySvgPath = 'assets/svg/Butterfly.svg';
  final double height = 100;
  final Stroke stroke;

  const StrokeCardWidget({super.key, required this.stroke});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventSelectionState = ref.watch(eventSelectionProvider);
    final eventSelectionNotifier = ref.read(eventSelectionProvider.notifier);
    final isSelected = eventSelectionNotifier.isSelected(this.stroke);

    print('isValidSelection: ${eventSelectionNotifier.isValidSelection()}');

    return GestureDetector(
      onTap: () => eventSelectionNotifier.toggleStroke(this.stroke),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
        ),
        child: TweenAnimationBuilder<Color?>(
          duration: Duration(milliseconds: 300),
          tween: ColorTween(
            begin: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            end: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          builder: (context, color, _) => SvgPicture.asset(
            _getSvgPath(this.stroke),
            colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
            width: 1.8125 * height,
            height: height,
          ),
        ),
      ),
    );
  }

  String _getSvgPath(Stroke stroke) {
    switch (stroke) {
      case Stroke.freestyle:
        return 'assets/svg/Freestyle.svg';
      case Stroke.backstroke:
        return 'assets/svg/Backstroke.svg';
      case Stroke.breaststroke:
        return 'assets/svg/Breaststroke.svg';
      case Stroke.butterfly:
        return 'assets/svg/Butterfly.svg';
    }
  }
}
