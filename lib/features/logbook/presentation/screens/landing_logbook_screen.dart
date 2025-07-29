import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/calendar_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/carousel_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/data_container_logbook_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/primary_button_widget.dart';

class LandingLogbookScreen extends ConsumerWidget {
  const LandingLogbookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 200,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CarouselLogbookWidget(),
        DataContainerLogbookWidget(),
        CalendarLogbookWidget(),
        PrimaryButtonWidget(text: 'Add Swim'),
      ],
    );
  }
}
