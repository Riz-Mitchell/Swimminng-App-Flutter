import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class ProgressIconLogSwimsWidget extends ConsumerWidget {
  final bool completed;
  final bool isUsing;
  final StatusLogSwimsEnum status;

  const ProgressIconLogSwimsWidget({
    super.key,
    required this.completed,
    this.isUsing = false,
    required this.status,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (completed) {
      return Icon(Icons.circle, size: 12, color: metricBlue);
    } else if (isUsing) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: metricBlue, // Circle border color
            width: 2,
          ),
        ),
        child: _getStatusIcon(),
      );
    } else {
      return Icon(Icons.circle, size: 12, color: colorScheme.secondary);
    }
  }

  Widget _getStatusIcon() {
    String assetPath;
    switch (status) {
      case StatusLogSwimsEnum.selectPoolType:
        assetPath = 'assets/svg/pool_type.svg';
        break;
      case StatusLogSwimsEnum.selectStroke:
        assetPath = 'assets/svg/swimmer_icon.svg';
        break;
      case StatusLogSwimsEnum.selectDistance:
        assetPath = 'assets/svg/ruler.svg';
        break;
      case StatusLogSwimsEnum.addSplits:
        assetPath = 'assets/svg/personal_best.svg';
        break;
      case StatusLogSwimsEnum.completeQuestionnaire:
        assetPath = 'assets/svg/clip_board.svg';
        break;
      case StatusLogSwimsEnum.complete:
        assetPath = 'assets/svg/tick.svg';
        break;
    }
    return SvgPicture.asset(
      assetPath,
      width: 40,
      height: 40,
      colorFilter: ColorFilter.mode(metricBlue, BlendMode.srcIn),
    );
  }
}
