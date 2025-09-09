import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/shared/enum/status_card_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class StatusCardWidget extends ConsumerWidget {
  final String statusMessage;
  final StatusCardEnum statusType;

  const StatusCardWidget({
    super.key,
    required this.statusMessage,
    required this.statusType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
          width: 350,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _getBackgroundColor(), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Expanded(
                flex: 15,
                child: Text(
                  textAlign: TextAlign.center,
                  statusMessage,
                  style: textTheme.headlineSmall?.copyWith(
                    color: _getBackgroundColor(),
                  ),
                ),
              ),
              SvgPicture.asset(
                _getSvgPath(),
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  _getForegroundColor(),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        )
        // onPlay: (controller) => controller.repeat(reverse: true)
        .animate()
        .fadeIn(
          duration: 500.ms,
          curve: Curves.fastEaseInToSlowEaseOut,
          delay: 100.ms,
        )
        .move(
          begin: const Offset(0, 50), // start 50 pixels below
          end: Offset.zero, // move to final position
          duration: 400.ms,
          curve: Curves.fastEaseInToSlowEaseOut,
        );
  }

  String _getSvgPath() {
    switch (statusType) {
      case StatusCardEnum.success:
        return 'assets/svg/success_check_full.svg';
      case StatusCardEnum.warning:
        return 'assets/svg/warning_check_full.svg';
      case StatusCardEnum.error:
        return 'assets/svg/failure_check_full.svg';
    }
  }

  Color _getForegroundColor() {
    switch (statusType) {
      case StatusCardEnum.success:
        return metricGreenSecondary;
      case StatusCardEnum.warning:
        return metricYellowSecondary;
      case StatusCardEnum.error:
        return metricRedSecondary;
    }
  }

  Color _getBackgroundColor() {
    switch (statusType) {
      case StatusCardEnum.success:
        return metricGreen;
      case StatusCardEnum.warning:
        return metricYellow;
      case StatusCardEnum.error:
        return metricRed;
    }
  }
}
