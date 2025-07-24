import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/data_logbook_widget.dart';

class LandingLogbookScreen extends ConsumerWidget {
  const LandingLogbookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      runSpacing: 20,
      spacing: 20,
      children: [
        DataLogbookWidget(data: '72', text: 'Swims'),
        DataLogbookWidget(data: '5', text: 'Workouts'),
      ],
    );
  }
}
