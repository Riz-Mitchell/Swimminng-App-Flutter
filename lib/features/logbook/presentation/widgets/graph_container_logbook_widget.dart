import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/graph_footer_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/graph_header_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/graph_logbook_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class GraphContainerLogbookWidget extends ConsumerWidget {
  const GraphContainerLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final double graphHeight = 300;

    final double containerHeight =
        graphHeight + 18; // Adjusted for padding and spacing

    return Column(
      spacing: 10,
      children: [
        GraphHeaderLogbookWidget(),
        Stack(
          alignment: Alignment.center,
          children: [GraphLogbookWidget(graphHeight: graphHeight)],
        ),
        GraphFooterLogbookWidget(),
      ],
    );
  }
}

class AxisLabelInstance extends ConsumerWidget {
  final String text;

  const AxisLabelInstance({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
      ),
    );
  }
}
