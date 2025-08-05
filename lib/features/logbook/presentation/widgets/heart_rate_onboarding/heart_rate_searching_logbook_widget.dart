import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/heart_rate_onboarding/heart_rate_onboarding_modal_logbook_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/primary_button_widget.dart';

class HeartRateSearchingLogbookWidget extends ConsumerWidget {
  const HeartRateSearchingLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      spacing: 0,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            path: 'assets/svg/close.svg',
            isActive: true,
            overrideColor: colorScheme.onPrimary,
            onTapped: () => Navigator.of(context).pop(),
          ),
        ),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 20,
            children: [
              Column(
                children: [
                  Text(
                    'Hang Tight!',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'While we search for your device, please ensure it is powered on and within range.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 10,
                  color: metricBlue,
                ),
              ),
              // SvgPicture.asset(
              //   'assets/svg/smartwatch.svg',
              //   width: 150,
              //   height: 150,
              //   colorFilter: ColorFilter.mode(
              //     colorScheme.onPrimary,
              //     BlendMode.srcIn,
              //   ),
              // ),
              PrimaryButtonWidget(
                text: 'Next',
                onPressed: () =>
                    ref.read(heartRateOnBoardingStateProvider.notifier).state =
                        HeartRateOnBoardingState.results,
                overrideBgColor: Colors.transparent,
                overrideColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
