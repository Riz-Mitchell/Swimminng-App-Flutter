import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/add_container_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/carousel_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/graph_container_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/graph_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/date_selector_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/heart_rate_onboarding/heart_rate_onboarding_modal_logbook_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class LandingLogbookScreen extends ConsumerWidget {
  const LandingLogbookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      spacing: 50,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButtonWidget(
              path: 'assets/svg/smartwatch.svg',
              isActive: false,
              onTapped: () {
                _tapToShowModal(ref);
              },
            ),

            Expanded(child: Center(child: DateSelectorLogbookWidget())),
            IconButtonWidget(
              path: 'assets/svg/swimmer_icon.svg',
              isActive: true,
            ),
          ],
        ),
        GraphContainerLogbookWidget(),
        CarouselLogbookWidget(),
        AddContainerLogbookWidget(),
      ],
    );
  }

  void _tapToShowModal(WidgetRef ref) {
    showModalBottomSheet(
      context: rootNavigatorKey.currentContext!,
      isScrollControlled: true,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      builder: (context) => HeartRateOnboardingModalLogbookWidget(),
    );

    ref.invalidate(heartRateOnBoardingStateProvider);
  }
}
