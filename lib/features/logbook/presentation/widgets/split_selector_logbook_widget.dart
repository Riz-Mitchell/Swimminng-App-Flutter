import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/logbook/application/viewing_swim_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/viewing_swim_model.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class SplitSelectorLogbookWidget extends ConsumerWidget {
  const SplitSelectorLogbookWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final viewingSwimState = ref.watch(viewingSwimLogbookProvider);
    final viewingSwimNotifier = ref.read(viewingSwimLogbookProvider.notifier);

    final backIsActive = viewingSwimNotifier.canGoBack();
    final forwardIsActive = viewingSwimNotifier.canGoForward();

    return SizedBox(
      width: 150,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButtonWidget(
              path: 'assets/svg/Return_Icon.svg',
              isActive: backIsActive,
              onTapped: () => viewingSwimNotifier.goBack(),
            ),

            Text(
              _getSplitDistanceString(viewingSwimState),
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.primary,
              ),
            ),

            RotatedBox(
              quarterTurns: 2,
              child: IconButtonWidget(
                path: 'assets/svg/Return_Icon.svg',
                isActive: forwardIsActive,
                onTapped: () => viewingSwimNotifier.goForward(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSplitDistanceString(ViewingSwimModel state) {
    if (state.swim == null || state.selectedSplit == null) {
      return 'No splits';
    }

    String text = '';
    switch (state.swim!.poolType) {
      case SelectedPoolTypeEnum.longCourseMeters:
      case SelectedPoolTypeEnum.shortCourseMeters:
        text = 'm';
        break;
      case SelectedPoolTypeEnum.shortCourseYards:
        text = 'yd';
        break;
      case SelectedPoolTypeEnum.unselected:
        return '';
    }

    return '${state.selectedSplit!.intervalDistance}$text';
  }
}
