import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/home/presentation/widgets/swim_card_widget.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/slider_widget.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/swim_graph.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/return_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

class SwimsLandingScreen extends ConsumerWidget {
  const SwimsLandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ReturnWidget(onTap: () => ref.read(routerProvider).go('/home')),
        SwimGraph(),
        ButtonWidget(text: 'Add Swim'),
      ],
    );
  }
}
