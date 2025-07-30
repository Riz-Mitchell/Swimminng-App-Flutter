import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/carousel_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/data_container_logbook_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class LandingLogbookScreen extends ConsumerWidget {
  const LandingLogbookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 50,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButtonWidget(path: 'assets/svg/Calendar.svg'),
            IconButtonWidget(path: 'assets/svg/add.svg'),
          ],
        ),
        CarouselLogbookWidget(),
        DataContainerLogbookWidget(),
      ],
    );
  }
}
