import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/heart_rate_onboarding/heart_rate_intro_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/heart_rate_onboarding/heart_rate_permissions_logbook_widget.dart';

enum HeartRateOnBoardingState { intro, permissions, searching, results, done }

final heartRateOnBoardingStateProvider =
    AutoDisposeStateProvider<HeartRateOnBoardingState>(
      (ref) => HeartRateOnBoardingState.intro,
    );

class HeartRateOnboardingModalLogbookWidget extends ConsumerWidget {
  const HeartRateOnboardingModalLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final step = ref.watch(heartRateOnBoardingStateProvider);

    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          final offsetAnimation = Tween<Offset>(
            begin: Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(position: offsetAnimation, child: child);
        },
        child: switch (step) {
          HeartRateOnBoardingState.intro => const HeartRateIntroLogbookWidget(),
          HeartRateOnBoardingState.permissions =>
            const HeartRatePermissionsLogbookWidget(),
          HeartRateOnBoardingState.searching =>
            const HeartRateIntroLogbookWidget(),
          HeartRateOnBoardingState.results =>
            const HeartRateIntroLogbookWidget(),
          HeartRateOnBoardingState.done => const HeartRateIntroLogbookWidget(),
        },
      ),
    );
  }
}
