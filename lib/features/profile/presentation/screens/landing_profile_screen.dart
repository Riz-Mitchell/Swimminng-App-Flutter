import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/profile/application/profile_provider.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/data_container_profile_widget.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/carousel_profile_widget.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/hero_card_profile.dart';
import 'package:swimming_app_frontend/shared/application/providers/auth_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';
import 'package:country_icons/country_icons.dart';

class LandingProfileScreen extends ConsumerWidget {
  const LandingProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final profileInfo = ref.watch(profileProvider);

    return profileInfo.when(
      error: (error, stackTrace) => SizedBox.shrink(),
      loading: () => SizedBox.shrink(),
      data: (value) {
        return Column(
          spacing: 50,
          children: [
            HeroCardProfile(user: value.user),

            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                left: 12,
                right: 12,
                bottom: 0,
              ),
              child: Column(
                spacing: 50,
                children: [
                  // StrokeDistributionRadarProfileWidget(),
                  CarouselProfileWidget(),

                  DataContainerProfileWidget(),
                  SizedBox(height: 10),

                  MetricButtonWidget(
                    text: 'Logout',
                    metricColor: metricRed,
                    onPressed: () async {
                      await ref.read(authControllerProvider.notifier).logout();
                    },
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
