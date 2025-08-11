import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_split_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_split_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/distance_split_selector_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/stroke_count_split_selector_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/stroke_rate_split_selector_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/time_split_selector_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class SplitModalLogSwimsWidget extends ConsumerWidget {
  const SplitModalLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logSplitStatus = ref.watch(logSplitProvider).status;
    print('SplitModalLogSwimsWidget: $logSplitStatus');

    return IconButtonWidget(
      path: 'assets/svg/swimmer_icon.svg',
      onTapped: () => _tapToShowModal(context, ref, logSplitStatus),
    );
  }

  Widget _handleModal(
    BuildContext context,
    WidgetRef ref,
    StatusLogSplitEnum logSplitStatus,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(top: 40, left: 12, right: 12, bottom: 40),
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => _buildStepWidget(logSplitStatus),
          );
        },
      ),
    );
  }

  Widget _buildStepWidget(StatusLogSplitEnum status) {
    switch (status) {
      case StatusLogSplitEnum.selectDistance:
        return DistanceSplitSelectorLogSwimsWidget(
          navigateToStep: _navigateToStep,
          key: const ValueKey('distance'),
        );
      case StatusLogSplitEnum.selectTime:
        return TimeSplitSelectorLogSwimsWidget(
          navigateToStep: _navigateToStep,
          key: ValueKey('time'),
        );
      case StatusLogSplitEnum.selectStrokeRate:
        return StrokeRateSplitSelectorLogSwimsWidget(
          navigateToStep: _navigateToStep,
          key: const ValueKey('rate'),
        );
      case StatusLogSplitEnum.selectStrokeCount:
        return StrokeCountSplitSelectorLogSwimsWidget(
          navigateToStep: _navigateToStep,
          key: ValueKey('count'),
        );
    }
  }

  void _navigateToStep(BuildContext context, StatusLogSplitEnum status) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => _buildStepWidget(status)));
  }

  void _tapToShowModal(
    BuildContext context,
    WidgetRef ref,
    StatusLogSplitEnum logSplitStatus,
  ) async {
    await showCupertinoModalBottomSheet(
      context: rootNavigatorKey.currentContext!,
      expand: false, // keep at natural height (like your 500px)
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      builder: (context) => _handleModal(context, ref, logSplitStatus),
    );

    ref.invalidate(logSplitProvider);
    print('SplitModalLogSwimsWidget tapped: $logSplitStatus');
  }
}
